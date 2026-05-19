Return-Path: <stable+bounces-249430-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6LF1O/+5C2qfLgUAu9opvQ
	(envelope-from <stable+bounces-249430-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 03:16:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A7DB9575F7A
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 03:16:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 71ADF301913D
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 01:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 358B0282F02;
	Tue, 19 May 2026 01:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Dlsrecqd"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E17E2BCF46
	for <stable@vger.kernel.org>; Tue, 19 May 2026 01:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779153381; cv=pass; b=LReZ0d6t3m7BRguAgOFHsU77Uwv6Uq5C+w7xnfdTjG5DE8hA/YPrr+V0sGvyTTTLeBanfNmWPPTf7hdpqyO5u20WuU7uwBDO1lRWFh2dSvhkRx0Bxn2oRuGPMIIG3GiFmIEZXRcOnpemEyVzq/u8B/WMzEztDD5e7DGJRGwoayk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779153381; c=relaxed/simple;
	bh=OcdkspzN2k6uZSWX7hHNuUolL9rQdeRACcLR8seJ3HA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AUgb1B4x2+xFstPK6mxEdcFUYjQAOw3zFNjYF/JVNHLpBrXfWeNJCrWJIJCrJJy07YJ4qLTD9DEwgLH2v9bxf2AH9aTGAsMVRdAEbVXJLe/5/cEMWQ8CUAY12TXFibkolbhhd4MzM5XkKoIkyxELpsCubLRhurEiMV05LYFFavs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Dlsrecqd; arc=pass smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-1336742714fso46c88.1
        for <stable@vger.kernel.org>; Mon, 18 May 2026 18:16:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779153379; cv=none;
        d=google.com; s=arc-20240605;
        b=Wew80TmeZO1XskYoZ+2CxtRK/z+iDOs4qVa4+234xKTylVR1VqkRT0Rd33h7if1qXa
         uCxriQlhMxc/FVl8yNC5Eyro2cpBZG9dSHpAoUCoacROL1bFSXeVbM2DXEDvA0TioQKs
         fZmxydLg3fvR/XeRPlS71F8oZycsm2cX3JPbxbQSBlMQLC1zpRVifP8hduUODl8wbQ05
         R2nBjHUylowNPBAPZ4KBfyvXgnPs4ffnxrosoxTyDBRrmYV6lkUEKRg/HoX+BrGhF+Kw
         QwmAg3pyo7tkClmWFoPh8nhpFtYyA8UGlaoG0Cth/M+CaIXBjWFDgNQau/rXJPG4QV3O
         2FRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=6lAMmAv21bOhMBM666DjHC0UfdgXq8bdb8/pvlxld4k=;
        fh=C9A4sx3oH/T0DUAQwY8/3ZUWybMIEJbofC5rG6Obfa4=;
        b=BfOQvdWA3gRWsXKiQFR8rcA8nt3N/SrTYheYTKOicMJTyT3LDfQqI3G13clcOSRqtR
         Yztt7fYt+U5YjodcsGJlqgHwtrtB/QB0bYnwbxYPeIrFEe6HT/jb9Kn/FMq46MOqT6Ey
         C/K0UJVVIvRm6WOZOUrxvzRyVgKxdZ10Z1U4QdEEU86NUaxki7vWOe4bCLA+tnSOsOWM
         sMc26GRcal3WXPGIeQ1p1F9o4F+fT8zHUzxbrhdl8WDIFLCAlbimG2Qo6DjFlLn142l2
         4BcKXKoRfGWJO8POa7fXN05DyOKzZX8ORS9ryaGFHtcqFTdBAQl8QmWZFSpWRI7eckKN
         GTpQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779153379; x=1779758179; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6lAMmAv21bOhMBM666DjHC0UfdgXq8bdb8/pvlxld4k=;
        b=DlsrecqdILuq7mshyWdWNORcqoFP3CuQO2GP5iwS9CK5UwhaOEV5S1WytXdpz/ApeO
         Fep8D1YHksI0nEecrFRXwnbvyEtQpl3bXiF8qBTAGhbcE3LHv6BKTmkKV9lIjFKRJqek
         MgggF15EePFoIL638E5xhcEoqt5vIdNdjHln7ihdig+q/H1GFG7s8prrPGWXpBcScmMU
         jA9V7hgtEMaiA/jsme9QDABf5p5DqR4p8Qh5HsUHGYshXtpfWnkMEUQNsp4Hh+eKWWUj
         lt2KWvUF2elYC5oTLD0tzg0VqAQzBLmElROWfe6HRBVEotUgwlrd5p5xnGxyY1hi+Yl4
         Gk2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779153379; x=1779758179;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6lAMmAv21bOhMBM666DjHC0UfdgXq8bdb8/pvlxld4k=;
        b=UlN4BapcdIweNp3itVBTZlY7iwZDiyNdQlh/jnCaofeNg0wpJW8xcPbrDjmU/wgd7+
         TtUdHphix2Rj2vqwzHWNCW4/lPpU5EiZ9j4CaU2TGqlekqKYjLBn2I2/TSmOCoBWfK7q
         4aOLDevGRAgDn0mBzPOAh4hTwU6lcR78YK0ZEccGQf7qp+eyyQmMAhz4wkle73tEctzP
         N86TGpuTkCQxK2KYe9uNvmtO00j8VMhA9ylVC+3WHV0oHFI289kq/fCNJJJbrdzpOXU6
         2LOnuwIUB26o8cg4zHiDFibBPzTqpnYnXEzb+ugfdyyA/sOcXsMIwPChdldHTzRRs65K
         w60g==
X-Forwarded-Encrypted: i=1; AFNElJ+W3lzG+MVw46GpafjiUmtZ2c8+HudW8zMWDfLtzcumjgncchhaXuhFVZWR4UkZn/K30n6svJQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGi8BuqxxzfsmOcdeik96FNYpQWLt9Oedq0EjuqGRMIBH22ZFb
	qvR8b2Yalc54jed9drgDvPGXy7roCO5cmPulHGVvFek4Ewd6gCLiLwkxIiz9oTVYS70mSezHgpl
	k0CqpMNzurUQ73eimc+qyq7jIHfhc4pu+Ugtp+Uis
X-Gm-Gg: Acq92OEPereH9lF2pob0DSezW4A6AmlC5zytz/b0ax4dPvcoNps7bXZfidnNAkdAjyt
	975q/FX+dzvXoTx1qYZtsFnqe9Eo1Fdq7JzyyOVikIUlu26Y6gYu2z2n7kDUH2kcTmM+kRNfYaJ
	Apj3s069JSd2WIACbDhoQ/k0VAG9gmc8H38z+uhXiixGo1p026k8nV2q0m5f8V9VW4b5Aig8GIH
	KI6Ksel/YfbZjoeueyBQfuoZ9JeRD6EaugdwnHy3rnG3aMdwM+hOHK1bXUBuQ7acfM7xj+1NrXM
	RipczdVjX/yU7xr3yedabkJ5Szu5HteSsynl1LXt2IRl3pDLMaaLCWoIKA/J8QJTXrwZzV4N/FW
	SJQ==
X-Received: by 2002:a05:7022:6993:b0:130:5c2c:d255 with SMTP id
 a92af1059eb24-135586ca4d1mr208228c88.21.1779153377743; Mon, 18 May 2026
 18:16:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260210135822.47335-1-andriy.shevchenko@linux.intel.com> <DGLVIO9YF9PK.1WM118M9OSS0N@kernel.org>
In-Reply-To: <DGLVIO9YF9PK.1WM118M9OSS0N@kernel.org>
From: Peter Shier <pshier@google.com>
Date: Mon, 18 May 2026 18:16:05 -0700
X-Gm-Features: AVHnY4L3cMXr2oalyiGPR6hyMcWMvD9y1aqHbl4j1uzzIozENX94PTfsdzjghnQ
Message-ID: <CACwOFJSz63A9d=EZrapJs=zKeSzWVogtz8F=9SDwVfb5i7vviw@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] device property: Allow secondary lookup in fwnode_get_next_child_node()
To: Danilo Krummrich <dakr@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-249430-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linux.intel.com,vger.kernel.org,gmail.com,linuxfoundation.org,kernel.org];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pshier@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: A7DB9575F7A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue Feb 10, 2026 at 2:58 PM CET, Andy Shevchenko wrote:
> When device_get_child_node_count() got split to the fwnode and device
> respective APIs, the fwnode didn't inherit the ability to traverse over
> the secondary fwnode. Hence any user, that switches from device to fwnode
> API misses this feature. In particular, this was revealed by the commit
> 1490cbb9dbfd ("device property: Split fwnode_get_child_node_count()")
> that effectively broke the GPIO enumeration on Intel Galileo boards.
> Fix this by moving the secondary lookup from device to fwnode API.

I am not familiar with this code at all but from a sashiko AI review I
found the following comments.
Does this need to be addressed?

> diff --git a/drivers/base/property.c b/drivers/base/property.c
> index 837d77e3af2b..4217d00c76fd 100644
> --- a/drivers/base/property.c
> +++ b/drivers/base/property.c
> @@ -759,7 +759,18 @@
>  fwnode_get_next_child_node(const struct fwnode_handle *fwnode,
>     struct fwnode_handle *child)
>  {
> - return fwnode_call_ptr_op(fwnode, get_next_child_node, child);
> + struct fwnode_handle *next;
> +
> + if (IS_ERR_OR_NULL(fwnode))
> + return NULL;
> +
> + /* Try to find a child in primary fwnode */
> + next = fwnode_call_ptr_op(fwnode, get_next_child_node, child);

If the primary fwnode is a Devicetree node (OF) and it returns NULL because
`child` was its last child, `of_fwnode_get_next_child_node()` will have
already called `of_node_put()` on `child`. Will passing this already-freed
`child` pointer to the secondary fwnode below cause a double-put when
`software_node_get_next_child()` also calls `fwnode_handle_put(child)`?

If `child` is a node from the secondary fwnode, passing it to the primary
OF fwnode's `get_next_child_node` operation will result in `to_of_node(child)`
evaluating to NULL. This causes `of_get_next_available_child()` to treat it
as the start of the iteration and return the first primary child. Does this
create an infinite loop where the iteration loops back to the primary children
after reaching a secondary child?

Furthermore, when the primary OF fwnode's `get_next_child_node` treats the
secondary `child` as NULL, it does not drop the reference to `child`. Does
this leak the secondary fwnode child references during the infinite loop?

> + if (next)
> + return next;
> +
> + /* When no more children in primary, continue with secondary */
> + return fwnode_call_ptr_op(fwnode->secondary, get_next_child_node, child);
>  }

