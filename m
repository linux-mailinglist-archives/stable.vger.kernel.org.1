Return-Path: <stable+bounces-244212-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cK10J1wV+mlRJAMAu9opvQ
	(envelope-from <stable+bounces-244212-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 18:05:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 16DDC4D0DC4
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 18:05:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D5D5A307728C
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 15:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 799AA48C41A;
	Tue,  5 May 2026 15:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="joU5c9Tb"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7823B48BD4B
	for <stable@vger.kernel.org>; Tue,  5 May 2026 15:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777996693; cv=none; b=cSVRgRuYFPGsIOOG2cZy6us9xK77yaiZ1IR+7bLh8c+pxvpLZq8HeSycHyBK/pKXCqDktLQURuP7wB3gnd9I9e74co/1wrluvZPv9laZiJ6mpX2aQhr8FpS7mf+QR0rCJ+sUnVXzOi3Sw1o/ntbleND47UlRYECUmDYLnP9yvPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777996693; c=relaxed/simple;
	bh=D2o/PVb77AkBEhbzcdF37qpR3SjVgvH1lEK7F9GQx9U=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=iyfbBxkHH4Bcu/DT8QE3t1RsYZ58jHTwBMqC4xV0gkqFkfU6h/7dYS20V4jrlZeEwvkvFWEA+685wRtdd578u08fYSHVOYgJPhbJzkZoJvVaouiuL8tIwuoitCHkUoDmZWJh7HZjWmxNyHlgpVeCqJiBEn9W45KFT24yTfU7Dac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=joU5c9Tb; arc=none smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-654672a6d68so5394123d50.0
        for <stable@vger.kernel.org>; Tue, 05 May 2026 08:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777996689; x=1778601489; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aejSiLDsfk8IAFtVBk+tM96P+lkGFUJjyUFGj4omje0=;
        b=joU5c9TbCxNdu75tqqmlGj2AKZq2aqA5+gJdigk0uZm0lq+uIzREpJl5uKCsAOlvzW
         LTeL5TaKPxtUdJE4u5gY05JYLuyfCldGCM2573grKPgAMLhqWGMAW+o9j3ns+bva6Ty2
         L1elbmCtFtP+D3A+BDBNDiR8Fn0LaniOcXup6PXET9RlLfa2B5gKBjGfLynAKiPgG+EV
         qMppwOHPyZn3alRy+Sfxlg9VKR+ol8JFOuR/3dAYCj7s65amlzq7TBE0qvwOcKpDu7vr
         HR4TBKY03DgVDorDK4idCpI2xJn4Azr+Omn46Tlbq5DBYowG3/j8LGSd/alWffwfPA1+
         8cZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777996689; x=1778601489;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aejSiLDsfk8IAFtVBk+tM96P+lkGFUJjyUFGj4omje0=;
        b=HTHmDj9CE6alKbOu2WP+IcE2PvvvAv+9fWp6/DRA62pfKlbHxdI7jH0DM6CO64zGI9
         VAHlf37rTZEwDzFVthCUhvIODfJi9xZfzGNjPDxV//QcHGS4ukQ3ia1s1z1sNzuN+U0W
         YMZKhcJ2vtBeLOVkyhgXQuil3grPREsjLKCQPdAhBX2YWFIPkV7V/iUo8ZZkxtex5g4l
         54EYptGR/86lNJ1cRdOApObgFZEeuaYCd2qz5840JJncDOgF2YF5UTkEvtx6iwKVU3vk
         9iDc28rCWFCMFTo8QLT1doQo21WFcg/gV5Y3bJVbuPjnFuzjduNx0ZTkogloWp+SaS97
         6SSQ==
X-Forwarded-Encrypted: i=1; AFNElJ+chHNX3ySrdHIhjOznwZqozT6P4w0c+xqSBnyDRzKn+HzdiQxLz39+dE4OI6VmznNcYmr5I1A=@vger.kernel.org
X-Gm-Message-State: AOJu0YylqdyfRFsbIt4pUQ+ofOm11G+CJa9/TKCeksn73+g4MUmXgxDo
	dMmB5MoAcRJHd1fo4IIxkdOp/vTF6N4ZWLbp0X+yC2ZBye0a+FPYQYjT
X-Gm-Gg: AeBDieu8IJ8yRRyiz1nQwNKuoX1dDvrCLOjMA761eKbvU674wYjW8JTnE/OCTTLMJ0K
	cl94zKPy9UozWKrmBlaat5naILSWPWoWZYyGzskq+XFymBd+mTJ4pWatM0j1oLnSi8F38IbsGCZ
	Ge/um6ecGHrN9SJY8q02tUuOLBGRdUudjoLvgTpZLXFR4pAawDFC1aC/lscpuTo2kqUp0cvjHwG
	IBTN4XZbTEhw9cF7YAmJfQtCuC0ta8dnzdQEPgqQ6lMhVS02/j+TTGKftj1rp/n0JZgU2oIjSIk
	XnffO72bSpSyNr+BWvo14/1TGfFwkb0+24rR0G06OsiHJstvucNvweM3Z0HkC7uL3hWUsos/416
	8vs1yGUz7C+HTzpgCHPS83rMDEab+Q0AfEd7Z35Hzru703VXtvBFH/Ia1Zmu6dzgrElczGfdYgX
	Uy2YGBBvKSYy9caV8eSWP0UYgdLbuH70S14qGyeDD7DxMGCc6gTO1fyi4KJP2sMNpr+uBYHbHCu
	4jJcudxFNBrOD8wJVYw50EwwA==
X-Received: by 2002:a53:b457:0:b0:65c:5b88:84a2 with SMTP id 956f58d0204a3-65c69c48b3cmr3048915d50.4.1777996689221;
        Tue, 05 May 2026 08:58:09 -0700 (PDT)
Received: from gmail.com (172.235.85.34.bc.googleusercontent.com. [34.85.235.172])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65c2e1d95a8sm7216162d50.9.2026.05.05.08.58.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 08:58:08 -0700 (PDT)
Date: Tue, 05 May 2026 11:58:07 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Maoyi Xie <maoyixie.tju@gmail.com>, 
 "David S . Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Eric Dumazet <edumazet@google.com>, 
 David Ahern <dsahern@kernel.org>, 
 Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, 
 Willem de Bruijn <willemb@google.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
Message-ID: <willemdebruijn.kernel.30d081513eee7@gmail.com>
In-Reply-To: <20260505072015.1672730-3-maoyi.xie@ntu.edu.sg>
References: <20260505072015.1672730-1-maoyi.xie@ntu.edu.sg>
 <20260505072015.1672730-3-maoyi.xie@ntu.edu.sg>
Subject: Re: [PATCH net v7 2/2] ipv6: flowlabel: enforce per-netns limit for
 unprivileged callers
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 16DDC4D0DC4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-244212-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,google.com,ms2.inr.ac.ru,gmail.com,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[gmail.com,davemloft.net];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,ntu.edu.sg:email]

Maoyi Xie wrote:
> fl_size, fl_ht and ip6_fl_lock in net/ipv6/ip6_flowlabel.c are
> file scope and shared across netns. mem_check() reads fl_size to
> decide whether to deny non-CAP_NET_ADMIN callers. capable() runs
> against init_user_ns, so an unprivileged user in any non-init
> userns can push fl_size past FL_MAX_SIZE - FL_MAX_SIZE / 4 and
> starve every other unprivileged userns on the host.
> 
> Add struct netns_ipv6::flowlabel_count, bumped and decremented
> next to fl_size in fl_intern, ip6_fl_gc and ip6_fl_purge. The new
> field fills the existing 4-byte hole after ipmr_seq, so struct
> netns_ipv6 stays the same size on 64-bit builds.
> 
> Bump FL_MAX_SIZE from 4096 to 8192. It has been 4096 since the
> file was added. Machines and connection counts have grown.
> 
> mem_check() folds an extra per-netns ceiling into the existing
> non-CAP_NET_ADMIN conditional. The ceiling is half of the total
> budget that unprivileged callers have ever been able to use, i.e.
> (FL_MAX_SIZE - FL_MAX_SIZE / 4) / 2 = 3072 entries. With
> FL_MAX_SIZE doubled, this preserves the original per-user reach
> of 3K (what an unprivileged caller could already obtain before
> this change), while forcing an attacker to spread allocations
> across at least two netns to exhaust the global non-CAP_NET_ADMIN
> budget.
> 
> CAP_NET_ADMIN against init_user_ns still bypasses both caps.
> 
> The previous patch took ip6_fl_lock across mem_check and
> fl_intern, so the new flowlabel_count read in mem_check and the
> new flowlabel_count++ in fl_intern run under the same critical
> section. flowlabel_count is therefore plain int, like fl_size.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Suggested-by: Willem de Bruijn <willemb@google.com>
> Cc: stable@vger.kernel.org # v5.15+
> Signed-off-by: Maoyi Xie <maoyi.xie@ntu.edu.sg>

Reviewed-by: Willem de Bruijn <willemb@google.com>

