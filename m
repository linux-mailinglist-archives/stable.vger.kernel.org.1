Return-Path: <stable+bounces-269490-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SmedJ8nNQGodiQkAu9opvQ
	(envelope-from <stable+bounces-269490-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 28 Jun 2026 09:31:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F41506D35B2
	for <lists+stable@lfdr.de>; Sun, 28 Jun 2026 09:31:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269490-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-269490-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7959030151C2
	for <lists+stable@lfdr.de>; Sun, 28 Jun 2026 07:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E0A833F5BA;
	Sun, 28 Jun 2026 07:31:08 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4937626ADC;
	Sun, 28 Jun 2026 07:31:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782631868; cv=none; b=AwnYJLFIZLj2w/p1nIbl0vRbuASswSjEQijdVNfiLGvsQg3uXOZSTKX4a6BL0Q2EkkY5hJP4AjGYoItpjJhOBei+VF617Qj1sG/H6HhxizjexwFBPlaZXKh8oJZ5/hudNSh4g6hu5ZMatKkTdsUG6Tq4bkgETWa5ui0Z32azauA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782631868; c=relaxed/simple;
	bh=EZuM9tIjkK9Bm52oBPRRnOgm/j1TJt1t7FG52vTzUSE=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=IrGfRf1XWiWwTB9QlowczLkTws9kM+DKx/dClADBkBdaEGPviFHLgq7AkKoddTaiQoXiuSv5yVzi1fsoEDw3IHbP3CJWDL1x6u0/+TkbnD56uiJE2nfEKViELQK1QImuZlwWnmWdO7ZXyxSGqWMMUg85YBON0y+KeI5rJdGjkKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Received: from smtpclient.apple (unknown [117.182.74.7])
	by APP-05 (Coremail) with SMTP id zQCowAB3zhGfzUBq4rG6FQ--.42871S2;
	Sun, 28 Jun 2026 15:30:40 +0800 (CST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.8\))
Subject: Re: [PATCH] fix: net/batman-adv: batadv_interface_kill_vid: extra
 batadv_meshif_vlan_put after destroy
From: WenTao Liang <vulab@iscas.ac.cn>
In-Reply-To: <20260627034636.59693-1-vulab@iscas.ac.cn>
Date: Sun, 28 Jun 2026 15:30:28 +0800
Cc: horms@kernel.org,
 b.a.t.m.a.n@lists.open-mesh.org,
 netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <60CD91EB-833B-40D9-8DCA-A982CE336041@iscas.ac.cn>
References: <20260627034636.59693-1-vulab@iscas.ac.cn>
To: marek.lindner@mailbox.org,
 sw@simonwunderlich.de,
 antonio@mandelbit.com,
 sven@narfation.org,
 davem@davemloft.net,
 edumazet@google.com,
 kuba@kernel.org,
 pabeni@redhat.com
X-Mailer: Apple Mail (2.3826.700.81.1.8)
X-CM-TRANSID:zQCowAB3zhGfzUBq4rG6FQ--.42871S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr18XF17Jr1UJrWrXFyfXrb_yoW8Xr4kpr
	WUKFW3KFZxCayxKa9rKFy5uF1j9w4Skry0kF9akw4rAwnrta4Iga4F9r9rXFn5CFWxKF17
	Jr4UCas7X3WDWrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvCb7Iv0xC_tr1lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I
	8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
	64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8Jw
	Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkI
	wI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr
	0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY
	17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcV
	C0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY
	6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2Kf
	nxnUUI43ZEXa7IU8U5r7UUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwIMA2pAixFu8QAAsl
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-269490-lists,stable=lfdr.de];
	DMARC_NA(0.00)[iscas.ac.cn];
	FORGED_RECIPIENTS(0.00)[m:horms@kernel.org,m:b.a.t.m.a.n@lists.open-mesh.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:marek.lindner@mailbox.org,m:sw@simonwunderlich.de,m:antonio@mandelbit.com,m:sven@narfation.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[vulab@iscas.ac.cn,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vulab@iscas.ac.cn,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[iscas.ac.cn:email,iscas.ac.cn:mid,iscas.ac.cn:from_mime,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F41506D35B2



> 2026=E5=B9=B46=E6=9C=8827=E6=97=A5 11:46=EF=BC=8CWenTao Liang =
<vulab@iscas.ac.cn> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> In batadv_interface_kill_vid(), batadv_meshif_vlan_get() acquires a
> reference on the vlan object. batadv_meshif_destroy_vlan() internally
> calls batadv_meshif_vlan_put() which balances that reference. However, =
an
> additional batadv_meshif_vlan_put(vlan) is called after
> batadv_meshif_destroy_vlan(), causing a refcount underflow and =
potential
> use-after-free of the vlan object.
>=20
> Remove the extra batadv_meshif_vlan_put(vlan) call.
>=20
> Cc: stable@vger.kernel.org
> Fixes: 5d2c05b21337 ("batman-adv: add per VLAN interface attribute =
framework")
> Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
> ---
> net/batman-adv/mesh-interface.c | 3 ---
> 1 file changed, 3 deletions(-)
>=20
> diff --git a/net/batman-adv/mesh-interface.c =
b/net/batman-adv/mesh-interface.c
> index e7aa45bc6b7a..cc974f243200 100644
> --- a/net/batman-adv/mesh-interface.c
> +++ b/net/batman-adv/mesh-interface.c
> @@ -691,9 +691,6 @@ static int batadv_interface_kill_vid(struct =
net_device *dev, __be16 proto,
>=20
> 	batadv_meshif_destroy_vlan(bat_priv, vlan);
>=20
> -	/* finally free the vlan object */
> -	batadv_meshif_vlan_put(vlan);
> -
> 	return 0;
> }
>=20
> --=20
> 2.39.5 (Apple Git-154)

Please ignore this patch. I will resend a proper version after
learning the kernel submission process.

Apologies for the noise.

Best regards,
WenTao Liang=


