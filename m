Return-Path: <stable+bounces-212790-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YP23HBeFe2mvFAIAu9opvQ
	(envelope-from <stable+bounces-212790-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 17:04:39 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CAA66B1C9E
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 17:04:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6024B30247F3
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 15:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90B893314AE;
	Thu, 29 Jan 2026 15:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EdfEWwGk"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3938318B94
	for <stable@vger.kernel.org>; Thu, 29 Jan 2026 15:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769702379; cv=pass; b=YhsKQf0KR37LCVP+mI//b1ZhYy8rGwrn5XBiKBJEf4R9PqNKILVuctIZ+aQ+yExxSxRjQJJF6Ms/idzlsJCej609lkQ699Hi3Wte9mKou/37tZCaO3AyI58ySvovw+MrG0GXiYlwx3mC6mZYfSZL/DKfIhxS1Xw3/ep5cnBKYK0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769702379; c=relaxed/simple;
	bh=jP6B/+HWGupxxJrmj9WayxckdF/Nn9MjSYPmAAE2/5A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SzdZO9wFAANnB+YYDnwr7jtMCnvLuRRaCLmJ1yXg6EvDde025Xrbmm0+czoVe7k4F6/QAqGITobu/370s81ON5/PDtKQngIQc5ugz+albczZ8HJ9LVvatHfXsyCtM1GP0R5Tn5vvFfoujLW4saiiUNue3g7/haLQqXfGwZhVseI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EdfEWwGk; arc=pass smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-124899ee9d3so769085c88.0
        for <stable@vger.kernel.org>; Thu, 29 Jan 2026 07:59:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769702377; cv=none;
        d=google.com; s=arc-20240605;
        b=kuZf5YLi/S1W9zZNGpmRFBEnW+8LT+2MuLmlBoQlRIBgIBs7aQj4FLkwsNGiMQl0eq
         AR791UwObOetPLe3H9ZXkF4Gq10KRMZRajIu9U7o27CnWIUeXrtNH2sOUZVQZ/Nxqx40
         TjgvEzzeSRv8E3DJE59NC9ltva77i++lwJUwlrHGZQHklxd3FFwFOZejUIwVrx0/Idan
         A7jh+8qclmiHyaVWoJnGgQH34IGuHofRlwFZdDfCKgmf0qA9nW6LwHa+wGn/SS/X6M4r
         iFotJxGyKO9cvt2n9yO8QwIXMtJIu4OAQxeAibmNDpUrNvqt7TOXiHLb5LH2wHk7W/7v
         398Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6mJvDD1VpYWneH4exWtlRRFpCw/yxXuXg63uajYfPqQ=;
        fh=pW2kv9kXDAOpsujG6nbh83mMuyYMpeHkLjKluDlpnOw=;
        b=cpV8XLwFVDJ2RfiwRTqKyCuGXfZWd/ZYbSn2OThE0F57heebl+OjollZne24bPfD/P
         0s7g/I9ywg6piVmop2OE465iacRuT6xWjzeDl6aniOAk5UGD5WadhtWfQhW8gNRJ+weq
         0VieBargdCgwzskTqkkA2CzOwvxqn5IdclKNmZPSsjxKtx/EgBD3X4PM8MxblaRbNq5M
         6mDNGToDpqO+89C5KLNjGAQHd23lUAMBcC6hOz/iuF718MXGnvZiqhsboTozOwGi0Ui0
         1h+QkrwikoTEamboTBs24QgGA8QUANmUg4qYizAh7J+q0RytQTOUgxNlOMNJ7r5H17Rh
         eMSw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769702377; x=1770307177; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6mJvDD1VpYWneH4exWtlRRFpCw/yxXuXg63uajYfPqQ=;
        b=EdfEWwGkzAuOGOF5BJMUWNaOWgA1nMUTgFlBKcxPW53Vyh6Yh5T40lWEkrmox/G0SC
         kvyEoHaVxqsLoe9BrCa/IND4L3W+FWSpmeScWwvEW48ZvEobQGfwWE3017QD7SWHhpCE
         9gUXaYdv0LzqNmGqmB43zwoPFpsXPo6tHg3sWCB9dTYYzOFzuQzpVpAHN1AZiqqTjlkO
         hcNo8LraGf4LGcVOSxPCsYbpnqXkXL0vxEdb+KlyvNuEozDZ/yp2H1r+S+vgqLOI1P/H
         J3SPbWJm8gqpBU9qCWWm3Mo6F/H16G2ji0CWgruuIrKUD4taLSg0NqxKT3cNw9jzC5D6
         18Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769702377; x=1770307177;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6mJvDD1VpYWneH4exWtlRRFpCw/yxXuXg63uajYfPqQ=;
        b=F10ID+Nfq/fHkfrngEk3CLx3QqRWzsiXGJ9oFm58BsuMkdUJh2auJLx0r3ZJkNyVhw
         06cX0dnq5d1CYmTlHNgAHN0jlNJh9me41YefTMxBhKHU4dy7nomZcWnoUG2GRy5CkPbL
         sSGQ5U1UhgDID+enPjzsy3UAseNVqsbFt79UJ+ETPkdbsfoU7jLu63JIs3eFIi+Jbx22
         uPlFG1ux4OSm88Bw9Kpv07M6KvvpsuOpNqdrpZowGt4gcUF5DTJ7dmlFu10XnkyTzle6
         jo0gqdzXF73suEsy9scIqkDPphEnErsHkiYtBIZxOXaEHdVxLJ00k+msRvVym53dHbP9
         8S1A==
X-Forwarded-Encrypted: i=1; AJvYcCX7SyUJjwQ+5++ZNxMA8grH3NoGUuZVmx+d0UhqYa5wrEIi7O+rzl/zW6gu0ikwnyj+s+Z7nYc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzV0vE/Ui/C2N9l52Dvk0amn1zxuOWEo7ZkX0yFLQPd1RK9pzf+
	9XZzxJ/zHETmudC0lMrBuC1mHC7oa3GvdhM+Q6CfVqNkDqpSaYOK4V5xJtxOQIWL+U0mdQlZxKn
	MSx0ssDnRvN+cLVTyjMiHNwepPSDTeB0=
X-Gm-Gg: AZuq6aKGk4uSdqFRNOZQO3VlLazGQaSTSWo97QDK1Y8jPk8Dle4dqeQj5x2DRXVioAN
	YOZgHZmcxyy4bAi2PaQRteoCWQGbsuN/Lx+tVW95FKXbwO9PP92LloDoeXz9RoDO+Mi4NGFr3M/
	WZ/+uQZrWEF+7a3RAQ1Sy9KpKQs5a4Hp7x3suXcrGzBWE1F/yxEdiDO/xn4wUcGJc75zENd9H58
	RzUwGoqxqkw4Jw+HrPg88+aR0mIaLbtUgBaEN9xnW/VnMP2zc/18D780Krdm+CSH1C56z0dgXMq
	vK7ix3DWPm/W0VfbKfnZCXQWc7qjQFW7jZCJrSGz9P+XkC1om+nYJtfyRY5ETiDkETuWpp5DYjU
	VrqkFFH4R9TZH4A==
X-Received: by 2002:a05:7022:128d:b0:11b:f271:835a with SMTP id
 a92af1059eb24-124b100d8camr2199762c88.3.1769702377004; Thu, 29 Jan 2026
 07:59:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260129-imx-rproc-fix-v3-1-fc4e41e6e750@nxp.com>
In-Reply-To: <20260129-imx-rproc-fix-v3-1-fc4e41e6e750@nxp.com>
From: Daniel Baluta <daniel.baluta@gmail.com>
Date: Thu, 29 Jan 2026 18:02:21 +0200
X-Gm-Features: AZwV_Qh0LikHrjwYELL0Qb32OlZcL13Rg7Wtaiv5oFtOG766mVjbDDliX8TbUzs
Message-ID: <CAEnQRZA-nMai9-CEdMqnr2drqBRXXPOKE3a+_3j4S_=x-bM0pQ@mail.gmail.com>
Subject: Re: [PATCH v3] remoteproc: imx: Fix invalid loaded resource table detection
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Iuliana Prodan <iuliana.prodan@nxp.com>, Daniel Baluta <daniel.baluta@nxp.com>, 
	Frank Li <frank.li@nxp.com>, linux-remoteproc@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Peng Fan <peng.fan@nxp.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-212790-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,linaro.org,pengutronix.de,gmail.com,nxp.com,vger.kernel.org,lists.linux.dev,lists.infradead.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danielbaluta@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:email]
X-Rspamd-Queue-Id: CAA66B1C9E
X-Rspamd-Action: no action

On Thu, Jan 29, 2026 at 3:45=E2=80=AFAM Peng Fan (OSS) <peng.fan@oss.nxp.co=
m> wrote:
>
> From: Peng Fan <peng.fan@nxp.com>
>
> imx_rproc_elf_find_loaded_rsc_table() may incorrectly report a loaded
> resource table even when the current firmware does not provide one.
>
> When the device tree contains a "rsc-table" entry, priv->rsc_table is
> non-NULL and denotes where a resource table would be located if one is
> present in memory. However, when the current firmware has no resource
> table, rproc->table_ptr is NULL. The function still returns
> priv->rsc_table, and the remoteproc core interprets this as a valid loade=
d
> resource table.
>
> Fix this by returning NULL from imx_rproc_elf_find_loaded_rsc_table() whe=
n
> there is no resource table for the current firmware (i.e. when
> rproc->table_ptr is NULL). This aligns the function's semantics with the
> remoteproc core: a loaded resource table is only reported when a valid
> table_ptr exists.
>
> With this change, starting firmware without a resource table no longer
> triggers a crash.
>
> Fixes: e954a1bd1610 ("remoteproc: imx_rproc: Use imx specific hook for fi=
nd_loaded_rsc_table")
> Cc: stable@vger.kernel.org
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Changes looks good to  me >

> --- a/drivers/remoteproc/imx_rproc.c
> +++ b/drivers/remoteproc/imx_rproc.c
> @@ -729,6 +729,10 @@ imx_rproc_elf_find_loaded_rsc_table(struct rproc *rp=
roc, const struct firmware *
>  {
>         struct imx_rproc *priv =3D rproc->priv;
>
> +       /* No resource table in the firmware */
> +       if (!rproc->table_ptr)
> +               return NULL;

I wonder if we can make this change generic because it should happen
on other platforms also.

Maybe something like this:

remoteproc: core: Only copy loaded table when valid

Copy resource table in memory only when:
* the current loaded firmware provides one
AND
* there is an explicit request to have the rsc table copied in memory
via rsc-table

--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -1281,7 +1281,7 @@ static int rproc_start(struct rproc *rproc,
const struct firmware *fw)
         * that any subsequent changes will be applied to the loaded versio=
n.
         */
        loaded_table =3D rproc_find_loaded_rsc_table(rproc, fw);
-       if (loaded_table) {
+       if (rproc->cached_table && loaded_table) {
                memcpy(loaded_table, rproc->cached_table, rproc->table_sz);
                rproc->table_ptr =3D loaded_table;
        }

