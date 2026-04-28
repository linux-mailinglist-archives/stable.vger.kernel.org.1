Return-Path: <stable+bounces-241665-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KOQQM+C78GmFXwEAu9opvQ
	(envelope-from <stable+bounces-241665-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 15:53:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 46B6E4864F4
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 15:53:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0AEF43358355
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 13:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D12A944CF59;
	Tue, 28 Apr 2026 13:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="reZe0jAT"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 417E644BCBB
	for <stable@vger.kernel.org>; Tue, 28 Apr 2026 13:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777382063; cv=pass; b=qQlc+ZPCwFkVMBQ4vhZBLhYTnRxBPUYi2CIgH7Kc+AWzif3tvopbZ3xWsSIHVuRZyF0HiMev4hI8LPSICUH39Vnj5af92R6+F05kEFxc0C9/PSsCGkrpTc8XKL/VNyLvHCtWGGdOPVaPqNyKmOmtPDWYOYi5iNbzStMLyFlRMN8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777382063; c=relaxed/simple;
	bh=/pvgQuL7vphU/72KVdYS4OQfN6TiaqXigEAuLe2ShgY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N6Mvpreeq/NAB5fr29zSd95kRD7sIQy02ZN7Vq5IYXala8DFAW4uBUz4gwgcs4y/0/aSc9r1gi/uIeJ/R91Bh1ML4LV96GOmWk9IhOQ2OsxGHTYZmYd0tSoLpzQkfxI/lpTh7/qoqhSSRBYUudTmX6ne1p7KDIYtL3MT6GKigZs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=reZe0jAT; arc=pass smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8f15e900586so248010785a.1
        for <stable@vger.kernel.org>; Tue, 28 Apr 2026 06:14:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777382061; cv=none;
        d=google.com; s=arc-20240605;
        b=FvuaXOLzFThLP6aE33+piSTgkDhT8bPNGMjbZnRo4m0eAAMmZ4WrZpU3LF0dhJnVpD
         y1NxNhx+y4jnn1pRFkGQpJJ6WrtOTE5xOkcqGogRqD1qWiRkG2Jsby0mPs3ez9zEdtyi
         JDdsMkiH3x4Aa6mWv0r7qDw55O3vy7EH9B5/ZjdhEHvaeEcdIq7nqcr+iwNoOEJ9BDW9
         YJCy4P1m/vigRehygr1tXyh0XnSkhSZ/nSIHbv7xstRf/1vsMDMtFT/cTAEvmd5Jmrc6
         bjL+q8Rlz7tVhp45IgRrjfXDrjitVc/tgslRmQ1cN7VBOQ2AD8nz9b7BQH1n8qFMbOAC
         a1Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ph2KGeZYvECiBIV5t/7ReHLKmIw+/jWyacMkZ2Q4W34=;
        fh=69uh77KrHeGO4iJjuIO+B+Ltiwg5NlgJROpsUKIlbOI=;
        b=HjkeDV2pYfHdFUA1RHLF9Kg0fpbXT/0cwhW49kiVwIS5d3h5u4I58pD5J6mn1ZZEtd
         HpH8Hjhblj+VBquI8jDecwPXGRSLih9LJ0koTLdy4HwwE/BzCenK9dzzD+uAX5ftB4Ht
         z7M8htd/non2tTrrBKysKc6rXRJT7XJBekePjhetr7xwYaN5AEahc6952czoQ+H6+ilb
         4aIMt1oSfdvz+9bKy8Msr1GzmhrlpWAcYTi7whGxLn67zkYKvTrdF8+UJhnn4Ovam/EY
         i2d07VVb/1aIde2/dOuvehUE4Ra736FWAcfc3NHYi3Nba+zYNXC3b2z55aO7QnZsNysg
         bxbg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777382061; x=1777986861; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ph2KGeZYvECiBIV5t/7ReHLKmIw+/jWyacMkZ2Q4W34=;
        b=reZe0jATazrMApqmiPvLGnAqHzfZjSc/RL6VJ83Ano0FRokYM2BRE8ifJOh6QnlAtt
         qdUDoW+SKeiBa3V1yUVGpeMKSn0pmk7ghCNxj8/3E32DI+ET/TQNCA6VaeWTh+vuCRh3
         wFUpIwQGBzMuZByVU+D9VkMAxWKs0hw/+tlZwBrCAyNFjJyAtMIOTFk7uyKNZg3cRHSP
         o/T5ZiGkxZd6xSSuIV+DxbJkIB8auE5zbPx+As0aOmJr274No9oCtVR/qKjIjlr9+sJm
         dxyKSDyKJSyNhhx+TulZe6QspC2QMzcnE2SGIr5DM5UpJFGyPIajbaPaCXdMDeEF53PI
         HU0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777382061; x=1777986861;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ph2KGeZYvECiBIV5t/7ReHLKmIw+/jWyacMkZ2Q4W34=;
        b=Oy8Dc2uK+DuT82h8IvaZFx1BmjYxKbRwthHWrNLbfxnEFQ8AGslD3ci9b88D8CmZp7
         s8Z6LhUMpoK4zqrLOM+JGLEH2WCrNOvYQlgCT3D9DMqFqMiHaPCiN4Zv8E5xjnf1A2rw
         aWqI6Thw61z8NReSQLGgPbOBfGH0WoJIKA6uRfaN1buYIJuAnaxkxSBbJc+9U/S8RjZ6
         eoqbfItr6s4VA5VrYjq6gh/xx1qrDP5L0vGIfBjdwfaYrlI3ymonC15WkZuAmoqTTIHz
         OIMpfpdB9D37sw5UJ+36SLo865qpQygooLFzSHCybKOtPL/Z6ecQkK86I4U/7EDLDNyN
         ooxQ==
X-Forwarded-Encrypted: i=1; AFNElJ8VKk4Y3M8LuRjNbBoRQ0RB0kqwSsgJkIsUuy5C5BxTwpOMs/2rcA/egrUo6/Lrl8pN7ORjnVY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZLXN19dT80EidMTKAyVylws6PLOdGVA4Pt0wuN5jE/IdwhM3s
	pKPXIvZXCkbW8Vu5jqTSLcKYEft1Ywe/OrLDaHLov+xuAdWVY9SP63LeFurVFMjrvCFKrzpPzNc
	vvWBLWlJ46GpFqrY4c2iymvvZRBrx/rtqgvDHm/At
X-Gm-Gg: AeBDieuPUyp3SjJQv21v62pKar1sL8zDiV8Sp49lZ+b4h1b60owP54B6th5Ros9hutB
	hpLbbpKOsJ7XO2M2xVjbOKJJbIP3P6QxVmruzTPLYGsU3/P5l/OI1qGLMhKwiVvc3/Ce/mC824H
	6a/98BY2bvTJ3ihFHwBlV3vc7zXLRFfnjCv0Z5F7YOxUvXeoSBmYkJ8ZPDmn5TMoWYkaTZF9Cmn
	mts61F+hyT8vBHj2VYZhn9heNjpwFe26sG1bT7QDgd26Ry+LrUC0Bqc+yD5/kh+ttEAR63ePcB0
	4jqYNzFvjWTC4OAI5zCmxVZjU3fRkH0PKOFSQ3MdTVukuF3V3toFKmdVkWlargo6nRs+OB1WB5S
	dtbR7ZfJx
X-Received: by 2002:a05:622a:1983:b0:50d:cd5a:577b with SMTP id
 d75a77b69052e-5100e1a909dmr38694301cf.35.1777382060204; Tue, 28 Apr 2026
 06:14:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260428110713.2550315-1-maoyixie.tju@gmail.com> <20260428110713.2550315-2-maoyixie.tju@gmail.com>
In-Reply-To: <20260428110713.2550315-2-maoyixie.tju@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 28 Apr 2026 06:14:09 -0700
X-Gm-Features: AVHnY4Kj1O8tIjZZ71KmG_lSdWiR9NSfHmQ-lGRQOFxJHis0DQ-Gr4cC4qnWSpg
Message-ID: <CANn89iLa2+B2oZOpcShPDfaAmtJ6jUnEABVFim2fkyPTi=QK5w@mail.gmail.com>
Subject: Re: [PATCH net 1/2] ip6: vti: Use ip6_tnl.net in vti6_changelink().
To: Maoyi Xie <maoyixie.tju@gmail.com>
Cc: netdev@vger.kernel.org, kuniyu@google.com, shaw.leon@gmail.com, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org, 
	kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	security@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 46B6E4864F4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-241665-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,gmail.com,davemloft.net,kernel.org,redhat.com,ms2.inr.ac.ru];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ntu.edu.sg:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]

On Tue, Apr 28, 2026 at 4:07=E2=80=AFAM Maoyi Xie <maoyixie.tju@gmail.com> =
wrote:
>
> From: Kuniyuki Iwashima <kuniyu@google.com>
>
> ip netns add ns1
> ip netns add ns2
> ip -n ns1 link add vti6_test type vti6 remote ::1 local ::2 key 7
> ip -n ns1 link set vti6_test netns ns2
> ip -n ns2 link set vti6_test type vti6 remote ::3 local ::4 key 9
> ip netns del ns2
> ip netns del ns1
> [  132.495484] ------------[ cut here ]------------
> [  132.497609] kernel BUG at net/core/dev.c:12376!
>
> After commit 5e72ce3e3980 ("net: ipv6: Use link netns in newlink() of
> rtnl_link_ops"), vti6_newlink() correctly resolves the per-netns vti6
> hash via link_net. vti6_changelink() and vti6_update() were not
> converted in that series and still read dev_net(dev) /
> dev_net(t->dev), which diverge from the device's creation netns
> after IFLA_NET_NS_FD migration. The result is a stale per-netns hash
> entry; cleanup_net() of the original netns then walks freed memory.
>
> Reachable from an unprivileged user namespace ("unshare --user
> --map-root-user --net"); cross-tenant scope on container hosts.
>
> Fixes: 5e72ce3e3980 ("net: ipv6: Use link netns in newlink() of rtnl_link=
_ops")
> Reported-by: Maoyi Xie <maoyi.xie@ntu.edu.sg>
> Cc: stable@vger.kernel.org # v5.15+
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

