Return-Path: <stable+bounces-114328-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3958AA2D0F9
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 23:51:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41EBC3AA48C
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 22:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B84D1C5F1D;
	Fri,  7 Feb 2025 22:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PYX5dsnF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3F41AF0AF
	for <stable@vger.kernel.org>; Fri,  7 Feb 2025 22:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738968665; cv=none; b=Qgkmh57+0ajvIE8yIr3Du4kFvF3pgtZV43gSLjSwq1r/ouQWSDaGCmlnGv2XBLFPw/IiPqSkhBhvYZ8UDEt8/Y59uXRqtAcRMGQGY+XIukI8MxxHcBcYP02TPzGlxe+JNvhiVicsLVyqchxpYB8D/cZ/k2wYLOCZ5tYIkdAq8D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738968665; c=relaxed/simple;
	bh=ZXSJmpg9J325Q4367A9seMG+/2YPA6gjXu8LytFbgoI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=a6/uYswDhshTXxQnmSLn44lnU01tOyeUG5PICIvn3OTtIZsNcg9+SZcowRnTVNt5YMdo91MoF0IHkc+zoPZs8/RA855RetUKxxe9Ri01cBMu93Sh9ikvkZQ1QYIF4yxvaioJqKcoWrymgG6/srl8CyVR0JGdgmjvMIEBlBOn15U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PYX5dsnF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61AACC4CED1;
	Fri,  7 Feb 2025 22:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738968664;
	bh=ZXSJmpg9J325Q4367A9seMG+/2YPA6gjXu8LytFbgoI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PYX5dsnFRzjdDN29ZBadCtiqUTLHyO603HZiMFoPGmB4J5F4vIqOCbVcxpvYgGjuD
	 N8LfiuH6XOxKmJDZ6g9R4sgjYPvUy+uuKM+JgEv2maj0HGIplA6XFeh+wK8HGYt7jU
	 WYDBQxKpthoIsdDh2EfgqC5Ej0Y6Fw1+0miKsIDM9WJNYxRNhNsT9/hSh/50Lm/Bar
	 xjfVAYzk2gOwxS+SuCHv0RFosbL5DiBaCvhzOTW3fuv19l7nKl1UztJ6VgIyOVoso+
	 fCSI9rOKhlgoONQgVGSMedANUWw2ziDHN+IWJQqoZTw5UsUgsYqZ/2nW2cFkGmVI9Y
	 3PS/sk1kAPXng==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Xingrui Yi <yixingrui@linux.alibaba.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10.y] profile: Fix use after free in profile_tick()
Date: Fri,  7 Feb 2025 17:51:03 -0500
Message-Id: <20250207161727-d71a78a603cd0fd1@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250206072406.975315-1-yixingrui@linux.alibaba.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

[ Sasha's backport helper bot ]

Hi,

No upstream commit was identified. Using temporary commit for testing.

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.10.y       |  Success    |  Failed    |

Build Errors:
Build error for stable/linux-5.10.y:
    ssh: connect to host 192.168.1.58 port 22: No route to host=0D

