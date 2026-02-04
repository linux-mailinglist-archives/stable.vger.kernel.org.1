Return-Path: <stable+bounces-213738-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mCwHG1hgg2mJlQMAu9opvQ
	(envelope-from <stable+bounces-213738-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:06:00 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DA735E7E44
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:05:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 48F5B30292EC
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 15:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C5AF28853A;
	Wed,  4 Feb 2026 15:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eZoxheT4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D4528853E;
	Wed,  4 Feb 2026 15:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770217339; cv=none; b=nFnORPbLp9CmeAX2fFGNjYUQTc1Kuimio8vb1NCxB3fHBcjFsS6sgnryVqVBwM2WFgvXlGBzkE2Fgr0ep5szOKWe67R6CmDzJcuee24SAs+AyzNxVR7AyHPVcTXQRd2oqdfkcY/DA++vNzx47r8AZUtaFUoDgeAblu9nfdoRULc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770217339; c=relaxed/simple;
	bh=4B1rkkdOiiRuQxBrKrxmcujefzoeSCuuyhAPJfwqRoE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C8X98Fb0im5D44i1xbEXcgRkM9swPJRqAsQReyXHaDV8R/AKzvEdW0eoVfUgwJxl9iile1aYlDh1Pe+Wi59e4vuletqauR4uoBiRESc+8oRyybNuamQz4ymk1XONrpusFGTSnhcSJ/VZ682Yo3015EvO0JuYghxcfGggq9Wuz0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eZoxheT4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39552C4CEF7;
	Wed,  4 Feb 2026 15:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770217339;
	bh=4B1rkkdOiiRuQxBrKrxmcujefzoeSCuuyhAPJfwqRoE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eZoxheT4fwzq8RVy45fmY5/gKC7y+ylyMCS4FKFgXTTALrRySvZFynFaybxeCo+cm
	 XB/mVE0H/Yj3WHMdFijAomb1C0e07I4hLjFcc3ub1YxFja8EpTkZ8mjI9GUb7OBpf4
	 +NGhUgfaduBxNEX5vKe2PvTuV5rVkH8JmPZQzKsg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chen Ni <nichen@iscas.ac.cn>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Ben Hutchings <ben@decadent.org.uk>
Subject: [PATCH 5.15 194/206] net/sched: act_ife: convert comma to semicolon
Date: Wed,  4 Feb 2026 15:40:25 +0100
Message-ID: <20260204143905.210634124@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260204143858.193781818@linuxfoundation.org>
References: <20260204143858.193781818@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-213738-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[iscas.ac.cn:email,mojatatu.com:email,msgid.link:url,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,decadent.org.uk:email]
X-Rspamd-Queue-Id: DA735E7E44
X-Rspamd-Action: no action

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chen Ni <nichen@iscas.ac.cn>

commit 205305c028ad986d0649b8b100bab6032dcd1bb5 upstream.

Replace comma between expressions with semicolons.

Using a ',' in place of a ';' can have unintended side effects.
Although that is not the case here, it is seems best to use ';'
unless ',' is intended.

Found by inspection.
No functional change intended.
Compile tested only.

Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>
Link: https://patch.msgid.link/20251112072709.73755-1-nichen@iscas.ac.cn
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Cc: Ben Hutchings <ben@decadent.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sched/act_ife.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/net/sched/act_ife.c
+++ b/net/sched/act_ife.c
@@ -648,9 +648,9 @@ static int tcf_ife_dump(struct sk_buff *
 
 	memset(&opt, 0, sizeof(opt));
 
-	opt.index = ife->tcf_index,
-	opt.refcnt = refcount_read(&ife->tcf_refcnt) - ref,
-	opt.bindcnt = atomic_read(&ife->tcf_bindcnt) - bind,
+	opt.index = ife->tcf_index;
+	opt.refcnt = refcount_read(&ife->tcf_refcnt) - ref;
+	opt.bindcnt = atomic_read(&ife->tcf_bindcnt) - bind;
 
 	spin_lock_bh(&ife->tcf_lock);
 	opt.action = ife->tcf_action;



