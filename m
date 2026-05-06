Return-Path: <stable+bounces-244441-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aF8lO92V+2lHdAMAu9opvQ
	(envelope-from <stable+bounces-244441-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 21:26:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F4C34DFB50
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 21:26:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 44F61300AB32
	for <lists+stable@lfdr.de>; Wed,  6 May 2026 19:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40F7A318ED6;
	Wed,  6 May 2026 19:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BXrpt+uF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022123161AB
	for <stable@vger.kernel.org>; Wed,  6 May 2026 19:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778095575; cv=none; b=YTlIDblhBAgs9qgo6606jJFuFvF+wpS4RCRfXO5hCicZIq2Psd3n7ZcA1Rq2EdK2k25Fq3N/5bmgRDFEGcvA38ntKo+RYbJLa99lwmjfYAKnQpWQAiFz8dSk1OLtZNBBbIiainLTbVRFRXZ3klnlW3nUYS5iVAEao5R53Wxglco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778095575; c=relaxed/simple;
	bh=SHjwx8WAVtwlWVCkuLYCj4e2j7SsWE8uM4rrhcuQlZ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uhB1aLpTLLkflzPsbgShVS5wEe3RXbaaW1gfYrenPGkah42DgpMglbVAHrgV08lNZ97sjn5kNjsrJ22M8cbjehWH+p0o9MpZmTckllv6HFPN7yhnAZsRV89wg5srznaZ7NQpoedWyxdGPJGrAtMit6n4M7nP6m8aqK5jWM6aw4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BXrpt+uF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA6D8C2BCFB
	for <stable@vger.kernel.org>; Wed,  6 May 2026 19:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778095574;
	bh=SHjwx8WAVtwlWVCkuLYCj4e2j7SsWE8uM4rrhcuQlZ0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=BXrpt+uFj10aSYQHL8oQZHM2AqEsM0UKWSDgWWwYsKqxp2ilIUWNZjFo0jFBelIAj
	 fnhToU0a9U35cDet+0LuUH5z5V3sYbG2kg7GhjeyQyiAN/Z4bVikdHzO3TOtzkfT7v
	 10F1xiE3jNSZt4OYJA5QzYYhiBn3e766EIm6crYRWbdQAcH+jyd1q4nAt/Tqvl67+7
	 wMNyXOeKy7Iqo+b6UbsKtZ3af3oYuhJmi3oYRONBc1IzYSzcMQ54YfKDreEYIQ7D8c
	 LYrwTxWNc//2eOwQFnMaRkjEzDL1gy//n4k/6fk3Lknytr6rsZGl/doW1+aMH4GMO1
	 JtFoVIjXT01gQ==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5a0ff30b240so10113906e87.0
        for <stable@vger.kernel.org>; Wed, 06 May 2026 12:26:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9HXaT/dgQVy5rE/0VLTX3cGIeMiSbwOMzEqRcE1MbAQfR64Jsfc2FjQYmct+tnmgcPfD1G8YE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8uZnDPdZzVBdr+Rjb+BNmXSdgipSYu6Gq06kBBCNJJZJB1Ba9
	SiBYxFEtDApHC6lg9stt4vU8vm4smDaJ70APZSD+XsvjPMUMHXQDge0APF3s3lH6TdWdNcs7McQ
	3BNR/ee4EPNxz43X1blUFi/FNKQBLk7I=
X-Received: by 2002:a05:6512:4008:b0:5a2:bb8e:d4f4 with SMTP id
 2adb3069b0e04-5a887ae1897mr1782471e87.15.1778095572920; Wed, 06 May 2026
 12:26:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260506115701.23035-1-bartosz.golaszewski@oss.qualcomm.com>
In-Reply-To: <20260506115701.23035-1-bartosz.golaszewski@oss.qualcomm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 6 May 2026 21:26:00 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0h_mOTJh24nY2nMetb6+V9YX2k7pm9c4KQL0UnkNWfCBw@mail.gmail.com>
X-Gm-Features: AVHnY4KNiOZb3EUI-ZUonk7tswg3J53sY87FS-DrxRZKslELyo8d53tW5I3y3GE
Message-ID: <CAJZ5v0h_mOTJh24nY2nMetb6+V9YX2k7pm9c4KQL0UnkNWfCBw@mail.gmail.com>
Subject: Re: [PATCH] device property: set fwnode->secondary to NULL in fwnode_init()
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Daniel Scally <djrscally@gmail.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Len Brown <lenb@kernel.org>, 
	Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@kernel.org>, driver-core@lists.linux.dev, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, brgl@kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 4F4C34DFB50
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-244441-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,kernel.org,linux.intel.com,gmail.com,lists.linux.dev,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,qualcomm.com:email]

On Wed, May 6, 2026 at 1:57=E2=80=AFPM Bartosz Golaszewski
<bartosz.golaszewski@oss.qualcomm.com> wrote:
>
> If a firmware node is allocated on the stack (for instance: temporary
> software node whose life-time we control) or on the heap - but using a
> non-zeroing allocation function - and initialized using fwnode_init(),
> its secondary pointer will contain uninitalized memory which likely will
> be neither NULL nor IS_ERR() and so may end up being dereferenced (for
> example: in dev_to_swnode()). Set fwnode->secondary to NULL on
> initialization.
>
> Cc: stable@vger.kernel.org
> Fixes: 01bb86b380a3 ("driver core: Add fwnode_init()")
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

Reviewed-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>

> ---
>  include/linux/fwnode.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
> index 80b38fbf2121..31df7608737e 100644
> --- a/include/linux/fwnode.h
> +++ b/include/linux/fwnode.h
> @@ -208,6 +208,7 @@ struct fwnode_operations {
>  static inline void fwnode_init(struct fwnode_handle *fwnode,
>                                const struct fwnode_operations *ops)
>  {
> +       fwnode->secondary =3D NULL;
>         fwnode->ops =3D ops;
>         INIT_LIST_HEAD(&fwnode->consumers);
>         INIT_LIST_HEAD(&fwnode->suppliers);
> --
> 2.47.3
>
>

