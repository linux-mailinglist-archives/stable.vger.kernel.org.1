Return-Path: <stable+bounces-248014-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cOjaAyFGB2p6wAIAu9opvQ
	(envelope-from <stable+bounces-248014-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:13:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DA0A552D7F
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:13:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A9BF53071CAA
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 15:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7C61366820;
	Fri, 15 May 2026 15:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="M/zMkXIT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71DD2305674;
	Fri, 15 May 2026 15:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778860647; cv=none; b=NFlyWp71YAF8ZE6XOqU/ZWagCXtBxflWJ628vmDSOYtj5HFhtGMcckuMpSH9H5vHBCslUP15F6MEF5w6aDATiygdqqs5UPUHkoQby4qc0iOAT0akHkSeY8jSblTh4VeVtu4Uu/Ln7+GUD4DmjIqwhY3Om/cC3BfLBd9UBj2kpUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778860647; c=relaxed/simple;
	bh=lv+DmsJc7qRSTtc6bN5DicfWQU9HRIfsh84pqDtk5jU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uQ95ScpaSUl5sL4d3rhNArU7NWIoys2W0O25D//xitGuZQsTPAKPbyNAjYHSUwDGs2p1Xlb8sFxJP9iXqigL13KsY3kEXYUDai9RPeLQUPwyHVBTj7+TYnZMqA58RqSL0Q6eA955omjeoTmi1nXxLSzKZ57J7yTE/Z0mx3fQZCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=M/zMkXIT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07FA9C2BCB0;
	Fri, 15 May 2026 15:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778860647;
	bh=lv+DmsJc7qRSTtc6bN5DicfWQU9HRIfsh84pqDtk5jU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M/zMkXITVASV/VU1bl6vxkU6qUAzFxCsnPGkEzlc3jmRoOiq74YvjrwnRwYoc1j/m
	 bfW5Yc9KVISTQKRVJ8YmHN+n1hMd4BZPp7BDtr9g2FPvCMpfiZdtvBcBE6s2S1QWzS
	 wXg+jM1DEm7G/x2UoXpzkgORAg/GKneTEbIh2lpQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Lyude Paul <lyude@redhat.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	stable <stable@kernel.org>
Subject: [PATCH 6.6 008/474] drm/nouveau: fix u32 overflow in pushbuf reloc bounds check
Date: Fri, 15 May 2026 17:41:57 +0200
Message-ID: <20260515154715.236478438@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260515154715.053014143@linuxfoundation.org>
References: <20260515154715.053014143@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6DA0A552D7F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,redhat.com,kernel.org,linux.intel.com,suse.de,gmail.com,ffwll.ch];
	TAGGED_FROM(0.00)[bounces-248014-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.de:email,intel.com:email,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Action: no action

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

commit 2fc87d37be1b730a149b035f9375fdb8cc5333a5 upstream.

nouveau_gem_pushbuf_reloc_apply() validates each relocation with

    if (r->reloc_bo_offset + 4 > nvbo->bo.base.size)

but reloc_bo_offset is __u32 (uapi/drm/nouveau_drm.h) and the integer
literal 4 promotes to unsigned int, so the addition is performed in 32
bits and wraps before the comparison against the size_t bo size.

Cast to u64 so the addition happens in 64-bit arithmetic.

Cc: Lyude Paul <lyude@redhat.com>
Cc: Danilo Krummrich <dakr@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@gmail.com>
Cc: Simona Vetter <simona@ffwll.ch>
Reported-by: Anthropic
Cc: stable <stable@kernel.org>
Assisted-by: gkh_clanker_t1000
Fixes: a1606a9596e5 ("drm/nouveau: new gem pushbuf interface, bump to 0.0.16")
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[ Add Fixes: tag. - Danilo ]
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/nouveau/nouveau_gem.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpu/drm/nouveau/nouveau_gem.c
+++ b/drivers/gpu/drm/nouveau/nouveau_gem.c
@@ -679,7 +679,7 @@ nouveau_gem_pushbuf_reloc_apply(struct n
 		}
 		nvbo = (void *)(unsigned long)bo[r->reloc_bo_index].user_priv;
 
-		if (unlikely(r->reloc_bo_offset + 4 >
+		if (unlikely((u64)r->reloc_bo_offset + 4 >
 			     nvbo->bo.base.size)) {
 			NV_PRINTK(err, cli, "reloc outside of bo\n");
 			ret = -EINVAL;



