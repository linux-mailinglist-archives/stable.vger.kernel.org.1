Return-Path: <stable+bounces-254222-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gHqhItXCFGoTQAcAu9opvQ
	(envelope-from <stable+bounces-254222-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 23:44:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E0765CEE8D
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 23:44:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6000D30065EE
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 21:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D115F392C2F;
	Mon, 25 May 2026 21:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CuJCl26A"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6852D3803C8
	for <stable@vger.kernel.org>; Mon, 25 May 2026 21:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779745490; cv=pass; b=Q4qI6hff616/HKa8LD6OnGkRva+vrqHEkCZvocj5wvP43kDt+BEm2xpLdSr0FZ+hfsF7WQtmkTb68JJIDMap/a2m4tgazIVT09IWSXD5GD2oEFAoAeT4mD4Js/EQQoRQVBgl3OkID5SoblSNM+FaDbcK8Vgt/YJXCzYl9j8XwdU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779745490; c=relaxed/simple;
	bh=ohFb5JUUsqtnkWu+wQSsJVMsuG7CcJFkAaC28tSHXlA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H8r/Hi987a+0QicTqIgZ1Ma9Ra0cPF/FQE2eTCWNo8dsKFSn6pt9naQJwdmrS79VrYHqUNBT303mT1w6mOJcsv166JPSZ0rN7TvYzuIrAo4dnGmJqvpZUlrgvCcfKlygZpP8K3+5M/JkL0kIp148xdlPChIUZ4IYJ8zfMooYAv8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CuJCl26A; arc=pass smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-482de4ef03aso6501169b6e.1
        for <stable@vger.kernel.org>; Mon, 25 May 2026 14:44:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779745488; cv=none;
        d=google.com; s=arc-20240605;
        b=Vd2uEE8ECvys95q02bdrrrxtVgqgOnlP+h6feW/yLZnMIgefEddVw4Kq/2de5jAyKJ
         heDnHl/rJd4LbJY88AHyG7H+WeI9+W8a09cr3Quks8Wo/JepYLNmZQL0kg4e8S0Hs3C+
         DlFmx7T/6h4bSErtuXv+KIL33KMhwqUmBdovjmtC2uO6ocXhdAhPLpfC3t7X/gCl/flF
         7B3e7uSfwLjoJyJlBq2zbDG1JvlFBsCGcaObvs8tWSC4cZz8qLUb9lGrXzTY5yPXw5vr
         cDv1ZQLbOgVXp/abjcKQlaphzCNlrjrMjxKngGiC00bzGFHk0yVR5SYuhOJIrJryWnau
         C2nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=SJw+4vUxZAoayUGTaqsiP7xIKkIP7i9ALofQjy5tRac=;
        fh=eWrBuT0AKcFCFcAfcmEfg2lG1mq38QFHZm6KcyI/C8o=;
        b=jdLnhgMnnjhd6b6ygqhYN5qfW0ldWA1wcXvXgrXwndV0ukqZJQnwURR5dQY6QW/DmT
         wPAAx7UOBXUm7b9x47/vSORfpvdRV7fQf9dHVrV4xnVzXueT/rFkn6DUAp+PfBfHRZ7X
         zYdw1pUq5L3x6KiT9B40HUU5dp3uTOsUnJqSA0tDpbR2XKHVQ3j8UZffLXKAJDtzNwJM
         qXMth4l0TLx0jOWa6BdtC+waG3ELRaKXq6lCy8HwRoKIU0U4X8AMs0ioL2we0H8+9IIP
         VE30eKJ23+FoWCTp3KEA69NeUbLWkwqrZePrFQroYRzYDYcOqSa+Cvs0HJwarfx2cgL5
         UCVQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779745488; x=1780350288; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SJw+4vUxZAoayUGTaqsiP7xIKkIP7i9ALofQjy5tRac=;
        b=CuJCl26AetG7KSd/fTG+LAv4HpMsNupmHxk7fhNrWE2s7FlmzFLBp9287f9UeQLpoe
         JTeGpinGRZp35P4TpWwsrc5IktKf69zIZvSpqiawOL1Qin9oOHSGr8lbHpaY5V3zx+5r
         zx81Ny3+H2uyVgCCY6Ju6Ywy7gCt6TZYN41HQslN8PKbb/cUj9jSZSQGgy55gTZUQ3aR
         7e4ixTZZk+E+eQD0kdpvDYbPI6PL4APliHUB3TG2CdIKxy+nT2cE1TG8iK/+KfrL8oAQ
         0Z5JOfcW5qbM53aNVi8jQDnUXgH8VGBI8nSgHHUnUHyVNyVZjSsPexmVUz02NL/5M1NW
         qDiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779745488; x=1780350288;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SJw+4vUxZAoayUGTaqsiP7xIKkIP7i9ALofQjy5tRac=;
        b=JmsfK239QfgmurzpcPFWtF/fDEpRRA19quQaxNufPpP1RrjqAC5Q95mZlUmm5J3hOD
         ENt0DyCEmQiZhQ8FfO2POUU//h/oKM89X7T97Xs62zf0BunUTtE8vQR8O3BnHoRDt+8P
         h4+wdGczpPvkEapacz9c2yc0kf/9HFaft2bmcaUmIRX8V63e/DRkDE2x70xai0qjrorZ
         kJD3gg4g12H7iQeBZQqpvb0CTwa9MDFUDYaR4ZQRswtlyGY/WJw/EpghB5apmsJPoCMH
         p64MhWTSCoIVRA+Ijr2ZQTjnibnVp+rBEKunfzydddSWZDZ+GApUjOXObI9MAW393Ag4
         uqag==
X-Forwarded-Encrypted: i=1; AFNElJ/mKdpTIHLq88Ov+IhQ8J6joupbYkMRIIixdMjtabrL2RYy54x8li+2Du8KDzUZmcsgJ4XJhmw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6rQyJKLRiqZOk1r3R8J6W079tIfMn5F52TeNBuRKM+H06VijT
	RZZ+xwc/kvRuqO6YmEHdo+VY+PR3NHQlr7m3x8uDkoZrpa4iGtzYkOuiSRnBZCBWBysUl/8WbyL
	gi/2imQz7Lel9LIIaHAe2pjCZvoKoBQw=
X-Gm-Gg: Acq92OGH3lHwlTkrdw2MH4R2bXicdZDAAyuuVRIX6bfgsz1G/LJD+QYvYtXbyAgJjqZ
	sWvdxoXSprtelSbHasUyyxqMIuAa6prIrDO5rz/qZqcYHHKp0UEk34O+apO1U/lKfae4f8E2wjb
	hyZPEH5w/Keb0+EXUaeqJH8lgLF9g/L1kUMLAcciuD/9V+U6NGn5+8ympAf49Te32ZuvrKr2vRO
	3T/G/9XY62BsbIgf0IOiC2XwSRctoq9pXdEKVka/C2ZR06WxXuNcUj8U32p7ywGnTsZTzV+qHxY
	420yayIIqpmaV+tn
X-Received: by 2002:a05:6808:6786:b0:463:a42c:503a with SMTP id
 5614622812f47-4854ae802demr7862655b6e.14.1779745488308; Mon, 25 May 2026
 14:44:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260525201116.407338-2-kacper.kokot.44@gmail.com> <ahS--cPlhv6NHAcO@strlen.de>
In-Reply-To: <ahS--cPlhv6NHAcO@strlen.de>
From: Kacper Kokot <kacper.kokot.44@gmail.com>
Date: Mon, 25 May 2026 22:44:36 +0100
X-Gm-Features: AVHnY4L0Lr1XHbcvt5E12PJzwDX33S_ExYucZKBalfL_rpD9sdnEVwCRq6K5ujY
Message-ID: <CAG-Fur6f65LeVVRrK2PF9_JNyjEwd3jWR1vcChn-FqZFQrjK+A@mail.gmail.com>
Subject: Re: [PATCH] netfilter: TCPMSS: fix dropped packets when MSS option is unaligned
To: Florian Westphal <fw@strlen.de>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>, Phil Sutter <phil@nwl.cc>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-254222-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kacperkokot44@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid]
X-Rspamd-Queue-Id: 2E0765CEE8D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> Is this an actual, real world bug?  This code is 20+ years old, all that
> this hints at is that they are always aligned in reality?

No, as far as I know it's theoretical - I just stumbled on it while
debugging something else.

