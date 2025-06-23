Return-Path: <stable+bounces-157876-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A289DAE560A
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 00:17:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07EE816AA85
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 22:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B4E1226CF3;
	Mon, 23 Jun 2025 22:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2BPJMwGx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 060851F7580;
	Mon, 23 Jun 2025 22:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750716936; cv=none; b=I5BmFfzrY1KjSaqtvjZokeELh8OdEFlKcAodhgSc1J+0vxqOwQZT8km0SHuc1y/eCsE5vt+fNgUt/9ED5xpbqTYZzxRRmAVC47ii0jN+EoseRPo+nqnPUFY3qXBn6N0mw7qAU9Bd89/UWwaxUUw4v6Di+hi3E6IfWuiOSbf3LQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750716936; c=relaxed/simple;
	bh=D+VPGnV97ZQmT7fFwFmYREeS56vlZHMVGlpf72OxvhY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EzfLgD5U9KnaEqcWhDIJfPpgEsLv3M2sGRR3qxA4UOrDpl9WZnP9JC+7VwN17CYQnq5xXgscQXJo1P/wyKc+d5YfzGmw7iXrNNAxAheEL2BAgDgbOhQNkcy1R0wkGHrr4M6KhoB2ebBRxQEThtzT4gQLwXqnUDDf7y03UHoNIc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2BPJMwGx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4930EC4CEEA;
	Mon, 23 Jun 2025 22:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750716935;
	bh=D+VPGnV97ZQmT7fFwFmYREeS56vlZHMVGlpf72OxvhY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=2BPJMwGxMSuOHVyKtyt6EikR/5woRCcDq3hLTTWgchZ9b/gDErZARyB/aLl9uMWaW
	 xM1poj4FuxQAc0kx8w5Q8Xy896PFq4BdTer/C0Vyhn7GTbC7XqWSckUF4MaZFAS5+f
	 n/IAKEl9/5AyJhNGFomAGnXLoKUWEwx1Cf7KsTs8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH 6.15 570/592] Documentation: nouveau: Update GSP message queue kernel-doc reference
Date: Mon, 23 Jun 2025 15:08:48 +0200
Message-ID: <20250623130713.998008016@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623130700.210182694@linuxfoundation.org>
References: <20250623130700.210182694@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bagas Sanjaya <bagasdotme@gmail.com>

commit 553ab30a181043f01b99a493ba13f9c011eb75ae upstream.

GSP message queue docs has been moved following RPC handling split in
commit 8a8b1ec5261f20 ("drm/nouveau/gsp: split rpc handling out on its
own"), before GSP-RM implementation is versioned in commit c472d828348caf
("drm/nouveau/gsp: move subdev/engine impls to subdev/gsp/rm/r535/").
However, the kernel-doc reference in nouveau docs is left behind, which
triggers htmldocs warnings:

ERROR: Cannot find file ./drivers/gpu/drm/nouveau/nvkm/subdev/gsp/r535.c
WARNING: No kernel-doc for file ./drivers/gpu/drm/nouveau/nvkm/subdev/gsp/r535.c

Update the reference.

Fixes: c472d828348c ("drm/nouveau/gsp: move subdev/engine impls to subdev/gsp/rm/r535/")
Fixes: 8a8b1ec5261f ("drm/nouveau/gsp: split rpc handling out on its own")
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
Link: https://lore.kernel.org/r/20250611020805.22418-2-bagasdotme@gmail.com
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/gpu/nouveau.rst |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/Documentation/gpu/nouveau.rst
+++ b/Documentation/gpu/nouveau.rst
@@ -25,7 +25,7 @@ providing a consistent API to upper laye
 GSP Support
 ------------------------
 
-.. kernel-doc:: drivers/gpu/drm/nouveau/nvkm/subdev/gsp/r535.c
+.. kernel-doc:: drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/rpc.c
    :doc: GSP message queue element
 
 .. kernel-doc:: drivers/gpu/drm/nouveau/include/nvkm/subdev/gsp.h



