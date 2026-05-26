Return-Path: <stable+bounces-254286-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GCH1JttrFWoBVAcAu9opvQ
	(envelope-from <stable+bounces-254286-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 11:46:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F765D3A04
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 11:46:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 95C903035F26
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 09:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D4843D8917;
	Tue, 26 May 2026 09:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BDH9OoBh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37DB83D6CD3
	for <stable@vger.kernel.org>; Tue, 26 May 2026 09:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779788589; cv=none; b=VN2WfKBzoGELen0wnzi+OdskwbtgYOvpOzN56l4E1+9rsIqsLYEtVrPazsURltbB16Al9WGRmQhNHB2XjjqmRYqdLk2i1lak79GtIARHQr8xzsTfuP20NKt9L+e3EbPH5JsF0KlDyq/p7mVbflCW6YU7tMS3inwZeE8M9jtUiI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779788589; c=relaxed/simple;
	bh=alDY0VLhiiw+q18k2+1m0gPGRJP+XHHpvwzJhC5lVYQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uLMyIzz+cfEViUqH6NKrssJlNqE/S9GVptn8PQczXFPs200Ngg0KBO7y8gW9GrDSqBqOSacumFME/5ppTho7/FoOBhYlbRoQhk31xPCxmrDdtCwgmimdZdmNL2EcRZvLwssxefWDuJerhPzTRwiiUsMXxoz677oCMIH4pFRYuyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BDH9OoBh; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF13D1F00A3A
	for <stable@vger.kernel.org>; Tue, 26 May 2026 09:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779788587;
	bh=UcqjTht+MUxgDMUwg/gNtKlW5/gu1VlH6gwR/Pb6w1A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=BDH9OoBh6oYxKzt9hyvKPs4e1CDzid66Rm7vIzScL+Itfma/eT3etY8SGrLWzAPa1
	 epyAO95vbNR/fj9ALL/s+8U1FsTtGUVTiHwxHkSZxncH/TjtkBV5q9p1xoazvtd4ar
	 3BTJeuF5C0vxc1fHag0iWCCbHy+xC0XOBE3nJn+4iXBN7w75yfJI4BFxAjK6VNkeSp
	 vLvS64/0oxFnV3wwdYfJFUxlqKeqgs/nZ4jR5BwhrqRJ3YlSRATVvZ3lA16mqR3/dU
	 zUDkFr/UbiRru92jYuukzhUJf97xoGMG/PTdvk8dgGmaFZDpscdH3oEwivDkltMchI
	 aqAwV6M3z+cpA==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5aa0cf8bca3so9423992e87.0
        for <stable@vger.kernel.org>; Tue, 26 May 2026 02:43:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9UWfJgzWukfQAy+nXO22qYS/V72tMrrJhx+hypZ7I5y1qIZcHsv1n5Sm7YrQmjI6vlfVuDe6o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9/mvVIV+nTKVHHf6IOaYTLK4twr9lVoZu9WY1OxTpqqU0zn2v
	fBzbAPqJduOwxYBPpLcMiCO3d2fm84i/kWuj16e64Tt1Nq2g6OKRuHQ4uDFBTXH3PK7sE6YynyM
	qJ2RUDlIcys0kTpYaUpV5DKWGydM1pww=
X-Received: by 2002:a05:6512:3ba9:b0:5a8:f984:1541 with SMTP id
 2adb3069b0e04-5aa323cdd95mr4921929e87.37.1779788586638; Tue, 26 May 2026
 02:43:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260523080758.1375830-1-vulab@iscas.ac.cn>
In-Reply-To: <20260523080758.1375830-1-vulab@iscas.ac.cn>
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 26 May 2026 11:42:53 +0200
X-Gmail-Original-Message-ID: <CAD++jLkv8nLYh7nxFc7T2GK_dAzCtwaeTjjufiw98rfNsQqxuw@mail.gmail.com>
X-Gm-Features: AVHnY4LdvQAZtGXlgiR0wvq1XMSlp9LH_KdLB0B1QOu9MFa7z8oidO8-IDL4Ba0
Message-ID: <CAD++jLkv8nLYh7nxFc7T2GK_dAzCtwaeTjjufiw98rfNsQqxuw@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: pinconf-generic: fix of_node reference count
 leak in dt_node_to_map_pinmux
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: linus.walleij@linaro.org, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254286-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linusw@kernel.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mail.gmail.com:mid,iscas.ac.cn:email]
X-Rspamd-Queue-Id: 38F765D3A04
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, May 23, 2026 at 10:08=E2=80=AFAM Wentao Liang <vulab@iscas.ac.cn> w=
rote:

> of_get_parent() acquires a reference on pnode, but the reference is never
> released on any return path.  Add of_node_put(pnode) in the exit label an=
d
> before the early return path.
>
> Cc: stable@vger.kernel.org
> Fixes: 7112c05fff83 ("pinctrl: pinconf-generic: Add API for pinmux proper=
tity in DTS file")
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>

The code you're patching has been refactored, rebase you changes on the
pinctrl "devel" branch please.

Yours,
Linus Walleij

