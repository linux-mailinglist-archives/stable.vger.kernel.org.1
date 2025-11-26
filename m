Return-Path: <stable+bounces-197020-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 565EDC89F6F
	for <lists+stable@lfdr.de>; Wed, 26 Nov 2025 14:19:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4608A4E4199
	for <lists+stable@lfdr.de>; Wed, 26 Nov 2025 13:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8A1F2FFDDC;
	Wed, 26 Nov 2025 13:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qPqjvktJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6539B27B4FB
	for <stable@vger.kernel.org>; Wed, 26 Nov 2025 13:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764163185; cv=none; b=D0A+/FVBz3Il/zucvCkze603LWaarsc1LX2n/TicqP707hsw0ayPUk+RtAbOmh6btNXD7EXQVtHpZBHpLZ+vsbLvITe6quTJaqFnkh44Cl323Iwn6dkYRuVjU2QA9fnqpebGUQOJT1m8pDBnIRPjZQHNCvq7tkB1PrSEICX5g6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764163185; c=relaxed/simple;
	bh=4dgNFS0zpQyLA3zL2ePYF8hRRjWr/tK6e8KSy82Dn+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M89LAN6i1fmtDmClgJKJm6fVcmv+4Mdd45llIDUZKLOz9clgpeiEk8XHqzgohAUyZ37BO21nAKFvZ8ITMBfcO6q4RC0VjOt/Jk+ZjVnUqC5jzNbRDITfOXJwhVTt8ZYDJyCdpHQXQZKVWK5zstAKTNk+mH8E7Hq5N2ABeql0aQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qPqjvktJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D9D7C113D0;
	Wed, 26 Nov 2025 13:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764163185;
	bh=4dgNFS0zpQyLA3zL2ePYF8hRRjWr/tK6e8KSy82Dn+Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qPqjvktJtJAB2c0E7kM3ad4vUepfrbpIPXmncshcZX8t7pqCtnK9Bz2IqBD8h0Bl+
	 jOhtLinOEpJsGl8P0EAxAdrTP4oOMxaoUoNdhq0csM5lL+jlqDW9k+rIYqzlsiW7B3
	 U1Vyg2zm6iQpa1Zv3LWbyBHmezNB8AVOYTbHuoDz23eiH1yIyAODw7X0xYLZfUGzTY
	 k9FhzvDqi8IBxb/6m+CHFRour9Aw5OWtEZH0oqwJSYWiNQPdFfrDOnhYYDv+Z9lnmZ
	 qTb6ia3kA174JLB8SOPzib0NkJpUdmdlhWRXovOyBbA7i0QH6SbczYpbMPLya7zu/R
	 MlUSIbH1+6PZQ==
From: Sasha Levin <sashal@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: stable@vger.kernel.org,
	"Isaac J. Manjarres" <isaacmanjarres@google.com>,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 5.15.y] mm/mm_init: fix hash table order logging in alloc_large_system_hash()
Date: Wed, 26 Nov 2025 08:19:42 -0500
Message-ID: <20251126131942.1374666-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251120193625.2353017-1-rppt@kernel.org>
References: <20251120193625.2353017-1-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch has been queued up for the 5.15 stable tree.

Subject: mm/mm_init: fix hash table order logging in alloc_large_system_hash()
Queue: 5.15

Thanks for the backport!

