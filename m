Return-Path: <stable+bounces-236431-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6MqHH+QZ3WkJaAkAu9opvQ
	(envelope-from <stable+bounces-236431-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:29:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EC1533EF12C
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:29:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8E7C1303E8F8
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 531892741A0;
	Mon, 13 Apr 2026 16:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="v9v1NXhX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A5327466A;
	Mon, 13 Apr 2026 16:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776096888; cv=none; b=s3NAKdFFvF5chdvCg3C3UvEGLq8z4OrZ9Z9R+s4y758GqhxCcdI8uitUy16rRPtiLy+RUMn6MME8V2pJBG1b7yi4kUUf7g4UUYpM2fxUvy7nDphvjlVKiUjnchSnvup4iTM2KHwEZYNg6wGAdyQLlxBrREC/QtBBVWOZj0eFs+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776096888; c=relaxed/simple;
	bh=1Q28rT/0nyAjLT74tDPlQ/XbZWr/ZuZcl33XmyQ3NYs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hf75N30HtLD9JHkdTgKgUDQtVEcfGiamqz8EK5Ju5uZdNjyngRsF2DZVz8nuLwP/zisA9RZ5U9VQ5jQS4IzXSFVGFtb3CiKtkuYeCuk8vhPwKNYMkrxWnc10Tzagrd22k0R5b5ufaLFd3PaXb0KraaqD/JNixEGE6pcagegjuo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=v9v1NXhX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C169C2BCAF;
	Mon, 13 Apr 2026 16:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776096887;
	bh=1Q28rT/0nyAjLT74tDPlQ/XbZWr/ZuZcl33XmyQ3NYs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=v9v1NXhX06kwW2SQm9fqqnbnjrxv5dZSg7ob2YbqnirwVGlHieQOWM6f9Du51mxkB
	 feNtA5ChJPgQ5jmo1PG8WwxcSWxRFaseSHR3KrHsRYMthFKe6s5ddQfTgnvFuFD0Pc
	 YJRrvsRIv9dc54EWh7wMOiL/O0AkZvQLSdDsFCiQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable <stable@kernel.org>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH 6.6 03/50] xfrm_user: fix info leak in build_report()
Date: Mon, 13 Apr 2026 18:00:30 +0200
Message-ID: <20260413155724.630375209@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413155724.497323914@linuxfoundation.org>
References: <20260413155724.497323914@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-236431-lists,stable=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[davemloft.net:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,apana.org.au:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,secunet.com:email]
X-Rspamd-Queue-Id: EC1533EF12C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

commit d10119968d0e1f2b669604baf2a8b5fdb72fa6b4 upstream.

struct xfrm_user_report is a __u8 proto field followed by a struct
xfrm_selector which means there is three "empty" bytes of padding, but
the padding is never zeroed before copying to userspace.  Fix that up by
zeroing the structure before setting individual member variables.

Cc: stable <stable@kernel.org>
Cc: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>
Assisted-by: gregkh_clanker_t1000
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/xfrm/xfrm_user.c |    1 +
 1 file changed, 1 insertion(+)

--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -3740,6 +3740,7 @@ static int build_report(struct sk_buff *
 		return -EMSGSIZE;
 
 	ur = nlmsg_data(nlh);
+	memset(ur, 0, sizeof(*ur));
 	ur->proto = proto;
 	memcpy(&ur->sel, sel, sizeof(ur->sel));
 



