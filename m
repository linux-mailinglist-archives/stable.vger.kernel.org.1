Return-Path: <stable+bounces-197015-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BBC5C89DF6
	for <lists+stable@lfdr.de>; Wed, 26 Nov 2025 13:55:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EF81F4E3197
	for <lists+stable@lfdr.de>; Wed, 26 Nov 2025 12:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA4D32826E;
	Wed, 26 Nov 2025 12:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DJRcgHCP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B55C3203A1
	for <stable@vger.kernel.org>; Wed, 26 Nov 2025 12:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764161706; cv=none; b=nuZboJsaDpohw3hvctGRLVel+SCxiqOZ9Peiz5fGJiLAX3NC3LX7voadNLNnwlBVUJfZe4bV+nqFzR8/cJZWTNY13nEsHRyygasrKEhMEFOBz9NP2w1e14eNbYWhDMqO6cvtypICYsOYZGuZykGLXYCDl0Tb8F3kbLpcCKcmmns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764161706; c=relaxed/simple;
	bh=sCV4NWFa1f/JwzNxZ0kJSIyA74cZ+FuOOeYxqYRaUU8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BPTQHU6tHGInRJvgzaau8QgTGczEMzP6gYtmSkzLaX+7xBQ/j6vIGDQLlx7JpcXks5FwJrTC9EV84EPsVHJXoXiWC5CWx6taehQwk/VCWZJ+7rHGQiMa0pWpU4qpvYYr2l/FdmOvozoIsDG6aMSVu7tUP9GEUoRZW6nWKZhtiQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DJRcgHCP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 038EDC113D0;
	Wed, 26 Nov 2025 12:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764161704;
	bh=sCV4NWFa1f/JwzNxZ0kJSIyA74cZ+FuOOeYxqYRaUU8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DJRcgHCPiQM8B9FIvOj9hIBSAw1vYOBUtVcuFQ/sJ/CU9YOVLdQZ3ppGsAWXeBwrJ
	 ghBLT7yTbqXcSTA7H5GRIfb0MlFACD9u6kZuegiiY9yR8tQuc4PHtsLkjh/nJ3XDXB
	 jOX/UXGNKhTw3zSTM6elAf8+NfGzr4+6LYvz+3wqlFCbjiIIJGf8PQOeeSrcKqJs45
	 aoI3rOYuTQShCMY4cta8KoSZtLlMM/HOlWFZx28lYuXu3sgLnV/z4pdKE467UcQeCL
	 2ItDRr8NGbiafiqkuRcwNcSJ0g/No98fYjkJF1gxfK9DpJ1dfWGRAUfYuCvyBPFbBB
	 IdfSCbHjEqWUA==
From: Sasha Levin <sashal@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: stable@vger.kernel.org,
	Lance Yang <lance.yang@linux.dev>,
	Google Big Sleep <big-sleep-vuln-reports@google.com>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 6.1.y] mm/secretmem: fix use-after-free race in fault handler
Date: Wed, 26 Nov 2025 07:55:01 -0500
Message-ID: <20251126125501.1368796-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251120191547.2344004-1-rppt@kernel.org>
References: <20251120191547.2344004-1-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch has been queued up for the 6.1 stable tree.

Subject: mm/secretmem: fix use-after-free race in fault handler
Queue: 6.1

Thanks for the backport!

