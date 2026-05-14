Return-Path: <stable+bounces-247248-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GIm6Jun9BWrFdwIAu9opvQ
	(envelope-from <stable+bounces-247248-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 18:52:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EC620544F44
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 18:52:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6B40B305A5C3
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 16:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55CE433B6DC;
	Thu, 14 May 2026 16:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F4x7wlSD"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC69E3195F0
	for <stable@vger.kernel.org>; Thu, 14 May 2026 16:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778777515; cv=none; b=kXb9JBA7aTDIKEd4/W0gHUvcEd/NAJ+/VTmYFlKT9vOjBWwLVfkBrVTbZ7qwojGu4j833V4bUJQhwel2LCCp4t+uskQjAiuIq5II7EZxXsxhIMJV/dnkvNv6NioV8PjqWu6mMd+Osg5KcByLsF8jaC69nS/CkyiH9n7am4gcqOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778777515; c=relaxed/simple;
	bh=xaDJ6AhrGPsK6Co3K1k8EdNzGxNV+cBSK5nP6nfNhss=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dvAQqTm+4KG+X6cNxCpGzyehphD8ifakOAI0qfhpW4CEo+c2DDKdbDHW4MuMI9awyE/prkzu4MRE/c+LyUAHCCS+xuLwYujAlA9riyhuaHe01NTFvX8uezytfIWBIwPJ9XLO52phyDe2bVMNqaEEYYPb9gJGEYy9lLq+jFvdnlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F4x7wlSD; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2babfd18435so41996515ad.1
        for <stable@vger.kernel.org>; Thu, 14 May 2026 09:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778777513; x=1779382313; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BDjribekpIomxI3HWRnZ6Olveu3FkT0qRUsHGP8CKgU=;
        b=F4x7wlSDyeiaJvXQbAP7F9XUi0vBKz9AkN9ORWP5acaXAy/K5ftR7fZo07po4MnkjE
         Wi6Q6vFFm8zW1PvGFPVXD3nDkQ8TiwZ6eZ/bMlpUSRYUviyxUMr0wyqZndIHM4ToaKph
         ONqxwJCnXN8oqY7s4zMN1FmC+3ru68QHZRXh+wz22pAedh73nlEyZqcijivKQiqN9mTh
         3KBjJKpLFMZ5YmYB4DNy8AQ8LcOvz76GyLNe3RHe6LK186fvI5A0RYs+GVVOQUrQvMSy
         wOuGC8MzKPkSeAWX61q5mE9632Mfj4lS8T4n/Kd3jgRb7psOtTn58dC9gZ1AFIGlv28A
         vlAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778777513; x=1779382313;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BDjribekpIomxI3HWRnZ6Olveu3FkT0qRUsHGP8CKgU=;
        b=soYvc3dIV35QRTUQO5YLki3qk2BgH4NhH3lKMs+IG4mYdpv9o/BPKiuQRip05ezYja
         F6as0XHoN2sCmw5EMnpxM0EbmIh6s0Yzq2IEpT6Ojayp9RnPz6zTZU0YbwxB8VXCYRgY
         Bm4ltndG8FWAm6k6WducXD/3cFXFbl9esdIIfsAPvZremg7Y+0oZb/B/8PPLDunvAg5G
         4ml+9SeuA19EtM6rdp3sxeGfyIAzPSqo/MZWHkKtA2TcNLR0EgvINExre6BQrymIFMcD
         eDLWMoAKjcw7WwDoeibAu3oObTfg/XNT9wxFIY+BcIGuDm4BG4rs7HPbl3GAoWZopmDT
         Qb/Q==
X-Forwarded-Encrypted: i=1; AFNElJ/cFUoz5DajuC5eE2KCGo0oMWz63ylZpi5RsbOiJ4oekTXZ3qqA1rJr8IzJGyozHd1z0ITS8a4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8pf1MnBVb9OyWp2NFRn6D1Qt7m3Rro8yJfMG73srcvKXbxhs/
	6y43nPIR7gvyq027MPGHEJ4nzflsJBCv6Bb23J++9uAfKVhhOmI4SdKt0Nv0Vtc9AdY=
X-Gm-Gg: Acq92OFhuue6GRwBLPBJoE/xJta0WeVcz+Fo0OvvtvBEKrlJBAPDq00M72haAnkmIuq
	6H8TtigVzYAW3Ug+7uFdGwK5aNyadhR80JteEmZgw2kKo1ht81jRiFAmoJ8XAt3wZhCp85AFfw0
	kFCPuUJjZXfdDJjsKTazxgGWA8HIBIB5QapmOtvmzT4gMweLmGm0DU6lJ7DgdKGbhIQ5pTV/T2v
	GaPjYzMk70+ObDekuuBTE+QHzhV25eIr4xkswWdm5vvoM1uDqi8jKpO0r7GOSnGuYsqbs+jjzUH
	PoKiDBI0UY0fDqqd5NVhHuV3kL6i0QlqSRsFcJF00J1xN7xvgGzgg/IUxRQmbRONccIfGnbkVES
	PAhnehWowEIs/Bx2u8ue3svUfx3dqeuQ/pxvIcTbMz3Rn8rAAzm0GtQYZvNQIiBGVuWWdcVKZhV
	nzOWeOH/Ac5BmzvYzaZBmmIeKi5BHj3g==
X-Received: by 2002:a17:903:2a87:b0:2ba:4eee:6c1e with SMTP id d9443c01a7336-2bd7e8214d5mr3623325ad.15.1778777513222;
        Thu, 14 May 2026 09:51:53 -0700 (PDT)
Received: from Tplus.localdomain ([114.243.117.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5c2631basm27937825ad.34.2026.05.14.09.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 09:51:52 -0700 (PDT)
From: Qi Tang <tpluszz77@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com
Cc: netdev@vger.kernel.org,
	lyutoon@gmail.com,
	stable@vger.kernel.org,
	Qi Tang <tpluszz77@gmail.com>,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net 1/4] ipv4: validate ip_options length in __ip_options_echo() against skb tail
Date: Fri, 15 May 2026 00:51:31 +0800
Message-ID: <20260514165139.436961-2-tpluszz77@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: EC620544F44
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,nvidia.com];
	TAGGED_FROM(0.00)[bounces-247248-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tpluszz77@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

__ip_options_echo() re-reads each option length byte (RR/TS/SRR/CIPSO)
from skb->data when building the echoed options into a 40-byte
__data[] buffer.  __ip_options_compile() saved only the option offset
into IPCB(skb)->opt, not the length.  An nftables LOCAL_IN payload
write reachable from an unprivileged user namespace can mutate the
length byte between parse and recvmsg, turning a parse-time validated
7-byte option into a 255-byte read.

  unsigned char optbuf[sizeof(struct ip_options) + 40];
  /* in __ip_options_echo: */
  optlen = sptr[sopt->rr + 1];        /* re-read; nft can mutate */
  memcpy(dptr, sptr + sopt->rr, optlen); /* into 40-byte buffer */

The destination is a stack buffer in ip_cmsg_recv_retopts() and a
DEFINE_RAW_FLEX() buffer in icmp.c / ip_output.c sized
IP_OPTIONS_DATA_FIXED_SIZE (40).  KASAN reports a stack-out-of-bounds
write of size 255:

  BUG: KASAN: stack-out-of-bounds in __ip_options_echo+0x7fc/0x1310
  Write of size 255 at addr ffff88800a657950
   __asan_memcpy+0x3c/0x60
   __ip_options_echo+0x7fc/0x1310
   ip_cmsg_recv_offset+0x58b/0xd10
   udp_recvmsg+0x8da/0xc20
   ____sys_recvmsg+0x1b1/0x620

Validate that each re-read option length stays within
skb_tail_pointer(skb) before the memcpy.

Reported-by: Qi Tang <tpluszz77@gmail.com>
Reported-by: Tong Liu <lyutoon@gmail.com>
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Qi Tang <tpluszz77@gmail.com>
---
 net/ipv4/ip_options.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/ipv4/ip_options.c b/net/ipv4/ip_options.c
index be8815ce3ac24..1cc6096e6dd9d 100644
--- a/net/ipv4/ip_options.c
+++ b/net/ipv4/ip_options.c
@@ -91,6 +91,8 @@ int __ip_options_echo(struct net *net, struct ip_options *dopt,
 
 	if (sopt->rr) {
 		optlen  = sptr[sopt->rr+1];
+		if (sptr + sopt->rr + optlen > skb_tail_pointer(skb))
+			return -EINVAL;
 		soffset = sptr[sopt->rr+2];
 		dopt->rr = dopt->optlen + sizeof(struct iphdr);
 		memcpy(dptr, sptr+sopt->rr, optlen);
@@ -105,6 +107,8 @@ int __ip_options_echo(struct net *net, struct ip_options *dopt,
 	}
 	if (sopt->ts) {
 		optlen = sptr[sopt->ts+1];
+		if (sptr + sopt->ts + optlen > skb_tail_pointer(skb))
+			return -EINVAL;
 		soffset = sptr[sopt->ts+2];
 		dopt->ts = dopt->optlen + sizeof(struct iphdr);
 		memcpy(dptr, sptr+sopt->ts, optlen);
@@ -145,6 +149,8 @@ int __ip_options_echo(struct net *net, struct ip_options *dopt,
 		__be32 faddr;
 
 		optlen  = start[1];
+		if (start + optlen > skb_tail_pointer(skb))
+			return -EINVAL;
 		soffset = start[2];
 		doffset = 0;
 		if (soffset > optlen)
@@ -174,6 +180,8 @@ int __ip_options_echo(struct net *net, struct ip_options *dopt,
 	}
 	if (sopt->cipso) {
 		optlen  = sptr[sopt->cipso+1];
+		if (sptr + sopt->cipso + optlen > skb_tail_pointer(skb))
+			return -EINVAL;
 		dopt->cipso = dopt->optlen+sizeof(struct iphdr);
 		memcpy(dptr, sptr+sopt->cipso, optlen);
 		dptr += optlen;
-- 
2.47.3


