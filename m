Return-Path: <stable+bounces-233545-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qPL1I+Xa1GlxyAcAu9opvQ
	(envelope-from <stable+bounces-233545-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 12:22:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 230613ACBBB
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 12:22:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 555023006108
	for <lists+stable@lfdr.de>; Tue,  7 Apr 2026 10:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46C7939B971;
	Tue,  7 Apr 2026 10:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CTMU9+da"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A4393A450C
	for <stable@vger.kernel.org>; Tue,  7 Apr 2026 10:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775557347; cv=pass; b=KynNJezA1nGOmE17fmrSEnh3ELsP3xCf/5XhMAIW+hQ1jUaWS3Y8Ab//gqycwOYKAqhHAFPJiM/4pmfPy6YN08tPO1rbINqASl1L8HRgwxDiTAgJI+TvZGk6XybCpQVONU1Pf2mAhLmVy4cFJY1YAo7rreC8YOl4OhvgLy+hR6o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775557347; c=relaxed/simple;
	bh=Ry+670M4aC9nVopfSukoNqqQRbVow/x6TQpNVc2OjSo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=AxNS0K2vQlc2lRMrKNT26coZxcJGVPE0KmFNbownJGoB+zdykuMUFKpa1spW4UvOonvkxbWkgKUxDXMFPkji8ujG2EqZ3h8mKciriAa3Rr5/LRSdhD2MTv+BlEQgLHbJMj/n+Db7basbcExwIJh12t6zSxJzawoxaPZSjOtHUGo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CTMU9+da; arc=pass smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-66bb66db39dso7408592a12.0
        for <stable@vger.kernel.org>; Tue, 07 Apr 2026 03:22:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775557344; cv=none;
        d=google.com; s=arc-20240605;
        b=Ci+81uHUEZ1Pr/CZ1xILBwB5yll7YKCBOIdceAUiSnMywP01EfzuTN2nJOjRNa2YkZ
         n8t9GF5j/sL4nLk3BJYQc4n8NhsU2+GwGu32r4CwtgZA0jwn6VqiEBFHBAoJpItOUz8C
         vpcb2O4uhJYcpElhKGflUnVrdyOxHxmmJqKiLPCzs1EvGIh2v097Yns9NuePiI0Oj8OS
         Yy9qj6afoc83/BfiiGZvjw/Pqs0qx2DPz5DxitUui9DHnh1cxIQrgcY956jVXnLpaXVW
         T3fZZKr25E3+tVq7zEzXLoiXBjJBi8zoN+2Yyi7It6DRVEbMJbStWs8qBEuQCAvD2/8A
         HVVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=Nv3TJ4e/E8xFH9xdVdNcrcuU4vA0S/CRqn+ui9vd0c4=;
        fh=6cFbB9axBA8uP/inBQQW9rfze7zHuFvrNyIrw7M6DNI=;
        b=I9Ync5gXLsXUsoS7Dd65torRKRAOFNvcoNzm7NfIKO1+wOyFfD6kV9W0viLfhcF8kl
         ulVQ31BkM62JdPrORpCDD70YKyLiCceTVliWym0Ra/SGbPnqlXNiYKvPOo7MHoXTpxxp
         0BTngZfH2ibwiwbXvxgPsCra3Zwcwv1alDcC6EiyCxj5e/fgLOcKdaRC9h5ow453IrCV
         02bQtJK7vuKcMnJyzx3S04BdTdfmOEAcbq9F1aOsf97Xm14DyYNnA5eMcxB+R1jIwMr5
         21KuzpNs84mgeUhH6Zo+1rRBEaHmJPMt9mdgwnYzXDcQif8zeFMzhRr8Rwt2BYCj1DJt
         R2Mg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775557344; x=1776162144; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Nv3TJ4e/E8xFH9xdVdNcrcuU4vA0S/CRqn+ui9vd0c4=;
        b=CTMU9+da8i8P32O6FHj+6t+Blg5ARzfQsbuMeiNmHJ75WKoLHav+cmZRqU3po2ovrt
         Yw4N9PHoiXNG3qLkfIwfaqjSaCSk19VDJ4LxcwChb5GuF6OSxgBp4Xy565D92q7qeZ01
         0t9InjLXb8n63awfQEG5b2QuRK0ezGLUYINou8B8A2TtWdrV46dPyKZg0ViciDTnXFsh
         /hqD2zcNyvfVvRRWECI8Gd8J8pSo4P/ildcORbbQ4FDJJggA0pMUGH7EvpkDdqMvPLou
         +3iOCSgUo9Ug0yWV6GpQqLqvKrcyDMxF7R3Hu7Bj/dBCfRjhM2VSD8ZTbQP3t4C5tbvG
         nahg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775557344; x=1776162144;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Nv3TJ4e/E8xFH9xdVdNcrcuU4vA0S/CRqn+ui9vd0c4=;
        b=AMuwFTs8/pW/EyBEJ6Oo2apa3J/MIzZgaz3YQEOLGCOr3FFGCoaPzKXR5lCsGYGi8v
         WVuJlCQQmP8SKtMhZz+XdurV4qhGid3QeYRRIu3ySUjyNPFefTs54Vz2f6kc5XPnwXFH
         XHo4zyOXJFEsvfa060jv6d+7IuunJFZ7ok8lhDmyvJajJWtpFY23NaGYlYRF7dQ26XvE
         uAR80pyIF51dgskeZp354cCd1gn0MQxSGB2tFhD+pAMPizPOXBCpTyY6KNrUxrvoICGH
         YaFjaStMn6Qe21Y0I0kw9ZWH9o2pW/whStpb+UIdOBMZlRERe4odQ99T2cRrrlihtSc6
         kF7w==
X-Forwarded-Encrypted: i=1; AJvYcCW+W8Hl+d2tmMqZGu0YvM83SFlPd24VsF7WMsAWlphNKLxt06w4x1lURdntAkl1+UfsyqfEq8k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNru1QVvmEqE9RarCYs8Zg7otbE5g348qwpHk6PiMoDIplmcId
	0lOn5vA408EcsvSylGroUyofEApG6yY3YifRMICHGs/v3kkCI5IWRx2BuIIFrnDFqHtjPUMz04d
	vIANIKittkFQ3OBHJP2O8AC6ukl8XvSCR5x9lJ7g=
X-Gm-Gg: AeBDieuLu/KLk0eqsdnLuj37XFtgenRIhud4G6iLLqTVYXn8KD8jx1Ql3vINwFmSeW0
	2OaqcIMQQydgKjIIhYJr71khkdwrIiRn+P/DwhRAi7x8++A/gn/cM7DfPIytemmCdg5vEmNHYYZ
	+4PH4C1q79qUk5BnJmqNLAzREJpspeQwh5N4uPtiIbmPCFZeSaEMI1cF2bHlDCPbKPxQ3L6ebhy
	pW4nqMLnSmQjgzLPFFQ6/lu/FpRIxf0Cawlwz0LaKWnJzfRiNYSpE14CxoKASD1cVprRnS1aNrQ
	mpLZ3K9UXgm/exlzgUwXTdSxTfpsXFS8vwnRdwjtIY6UVrsVQiYCP1iRUkObGUdqyUlIndcT2g=
	=
X-Received: by 2002:aa7:df86:0:b0:66e:4372:8ea8 with SMTP id
 4fb4d7f45d1cf-66e43728f36mr5162922a12.22.1775557343828; Tue, 07 Apr 2026
 03:22:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Kai Zen <kai.aizen.dev@gmail.com>
Date: Tue, 7 Apr 2026 13:21:57 +0300
X-Gm-Features: AQROBzCQyOFcf3eNz3WbxU392uw8y1QCtuu0B2xqk79tjJ3pTEUcyByx6NAE76I
Message-ID: <CALynFi7k1Z7Vgr4p2=KH2-uWVntBRE5R+8uP=cds9_ihGqzOdQ@mail.gmail.com>
Subject: [PATCH net] net: rtnetlink: zero ifla_vf_broadcast to avoid stack
 infoleak in rtnl_fill_vfinfo
To: netdev@vger.kernel.org
Cc: edwin.peer@broadcom.com, Eric Dumazet <edumazet@google.com>, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, stable@vger.kernel.org, 
	security@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-233545-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kaiaizendev@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 230613ACBBB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

rtnl_fill_vfinfo() declares struct ifla_vf_broadcast on the stack
without initialisation:

    struct ifla_vf_broadcast vf_broadcast;

The struct contains a single fixed 32-byte field:

    /* include/uapi/linux/if_link.h */
    struct ifla_vf_broadcast {
            __u8 broadcast[32];
    };

The function then copies dev->broadcast into it using dev->addr_len
as the length:

    memcpy(vf_broadcast.broadcast, dev->broadcast, dev->addr_len);

On Ethernet devices (the overwhelming majority of SR-IOV NICs)
dev->addr_len is 6, so only the first 6 bytes of broadcast[] are
written. The remaining 26 bytes retain whatever was previously on
the kernel stack. The full struct is then handed to userspace via:

    nla_put(skb, IFLA_VF_BROADCAST,
            sizeof(vf_broadcast), &vf_broadcast)

leaking up to 26 bytes of uninitialised kernel stack per VF per
RTM_GETLINK request, repeatable.

The other vf_* structs in the same function are explicitly zeroed
for exactly this reason - see the memset() calls for ivi,
vf_vlan_info, node_guid and port_guid a few lines above.
vf_broadcast was simply missed when it was added.

The pattern used elsewhere in this file for the regular IFLA_BROADCAST
attribute also avoids the issue by sending only dev->addr_len bytes
rather than a fixed-size struct, but for IFLA_VF_BROADCAST the wire
format is the fixed 32-byte struct, so the right fix is to zero the
struct before the partial memcpy.

Reachability and impact
-----------------------

The leak is reachable by any unprivileged local process. AF_NETLINK
with NETLINK_ROUTE requires no capabilities. The only environmental
requirement is that the host has at least one SR-IOV-capable
interface present (a parent device with VFs), which is the common
case for cloud, datacenter and HPC hosts.

Trigger: send RTM_GETLINK with an IFLA_EXT_MASK attribute whose
value has the RTEXT_FILTER_VF bit set. The kernel will then walk
each VF and emit IFLA_VFINFO_LIST, including IFLA_VF_BROADCAST,
which carries the 26 bytes of uninitialised stack per VF.

Stack residue at this call site can include return addresses
(useful as a KASLR / function-pointer disclosure primitive) and
transient sensitive data left over by whatever ran on the same
kernel stack just prior. KASAN with stack instrumentation, or
KMSAN, will flag the nla_put() when reproduced.

Reproducer (unprivileged):

    import socket, struct
    IFLA_EXT_MASK   = 29
    RTEXT_FILTER_VF = 1
    s = socket.socket(socket.AF_NETLINK, socket.SOCK_RAW,
                      socket.NETLINK_ROUTE)
    s.bind((0, 0))
    hdr  = struct.pack('=IHHII', 0, 18, 0x301, 0, 0)
    ifi  = struct.pack('=BxHiII', 0, 0, 0, 0, 0)
    attr = (struct.pack('=HH', 8, IFLA_EXT_MASK) +
            struct.pack('=I', RTEXT_FILTER_VF))
    msg  = hdr + ifi + attr
    msg  = struct.pack('=I', len(msg)) + msg[4:]
    s.send(msg)
    data = s.recv(65536)
    # Parse IFLA_VF_BROADCAST from the response. Bytes 7..32 of the
    # broadcast[] field are uninitialised kernel stack on Ethernet.

Fix
---

Zero the on-stack struct before the partial memcpy, matching the
existing pattern used for the other vf_* structs in the same
function.

Reported-by: Kai Aizen <kai.aizen.dev@gmail.com>
Signed-off-by: Kai Aizen <kai.aizen.dev@gmail.com>
---

Note for reviewers: this is v1. I have not yet identified the
exact introducing commit for the Fixes: tag and would appreciate
a pointer, or I will resend as v2 once I have run git blame on a
local checkout. The bug is present at least as far back as the
introduction of struct ifla_vf_broadcast in net-next.

 net/core/rtnetlink.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -1572,6 +1572,7 @@ static noinline_for_stack int
rtnl_fill_vfinfo(struct sk_buff *skb,
                port_guid.vf = ivi.vf;

        memcpy(vf_mac.mac, ivi.mac, sizeof(ivi.mac));
+       memset(&vf_broadcast, 0, sizeof(vf_broadcast));
        memcpy(vf_broadcast.broadcast, dev->broadcast, dev->addr_len);
        vf_vlan.vlan = ivi.vlan;
        vf_vlan.qos = ivi.qos;
--
2.43.0

