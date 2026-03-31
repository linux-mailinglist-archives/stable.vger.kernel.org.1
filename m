Return-Path: <stable+bounces-231326-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ENYZMrJgy2lZHAYAu9opvQ
	(envelope-from <stable+bounces-231326-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 07:50:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 31F3B3643E2
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 07:50:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0126D3053B31
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 05:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 014F5346AC2;
	Tue, 31 Mar 2026 05:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bRZOfr5z"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0254F2BE05E
	for <stable@vger.kernel.org>; Tue, 31 Mar 2026 05:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774936189; cv=none; b=DfiXcUsueNiPZT7BCtmiX03g2T6mo/QBTdUoShOL9qKreQngycXZQ9r19m8xAe0ZAmumNnebkwGHI5W26noZC1gHiiIGiXwN5Z5qMUKVfIEjSxE1Fv8/863BZ42wfiBITRYCfY0wbd2i1dj8aGAQYMDko4z7zy4LrXma87vNupI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774936189; c=relaxed/simple;
	bh=s8uPxYPuNODo2d+i6hzGWmLatHFJixudqC42WwqrVl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lwHPGfWAI4tFE0AUygWMoJ2olx/+6ZF8YwefVLR7c10Tp2TFDCSsdtlWJhTD3wbOIQ4igo7BNi/+fPwq2SlIXMuRyIg69w6L+FsR5GR9gX2fZL/WP95pkXdt35KlRtkS/sUQUagfwly+mHBOAKy23joz7r3kIKYdGeizl7o5xAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bRZOfr5z; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-2b4520f6b32so5814485eec.0
        for <stable@vger.kernel.org>; Mon, 30 Mar 2026 22:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774936187; x=1775540987; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=G6ZalXvRcEM7eynFKSA3Ox/Wlzblw8FW9y63x9o9NVw=;
        b=bRZOfr5zAIt3Ya7vBvT+HufIw5Afyn4RGp4f1HMs3VlNN1qhlEXre7q6iyxMT/7ucZ
         l68H/kkFBBqLmCmIUVUkN8Ebw6NcwVVt5++aaoXw8VDhwvjrmXFn8tVBAG8WlszUOnh4
         F/YtNDxlL4DSp5UIn8us9AG2W02NZ4kSWGGE4VIuZDwMcfuQ2GRZNEe9oupLFo57hvnT
         YNsz+HrIhKATnCdRHHASByGmfg82rwgXIovf+db7/sa2ny0/wLpgdeSf0BXABKbizrw0
         vFbT07sOab+UyUAtYMqFZFJhmJIydFMWMvmbb8cgPFHKjPfKcBxBj9porHH/V+JHevgn
         EPOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774936187; x=1775540987;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G6ZalXvRcEM7eynFKSA3Ox/Wlzblw8FW9y63x9o9NVw=;
        b=HnTbYcXXpPk226m8KhKwTyufYGderQyu89/UI3dyRUUW3si/i/i2JU3uHMUHfdWwsx
         Vtzt+tXVtK86w+QNlMOF6I8kR4yOX+IqXWW2QAJdzGStFmymn5wXnFSscXFiFe1MmtYU
         P4vWyMJBqI4x90etHOVSbgQ/SqcfLyvzHrKDesteBuWDDdYYHABxYnivkJdLOYTQxtMh
         Yjr4j77Ah4ppK1z6isvo783Lfl/daCoiN7PEmQ6IYCTRBaR05E4xllcPQ7M5osC5Tr21
         yls/X0ntsS3lyI428uFpbvKsMtscqhCVT5ebq1QLpkYmP2R+/QEQz0MTsJaX2ktzJDIh
         RZRQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHsBMUcCuocepqpLwBW3sZMEqpywaEcEktMUozZzTxJ8fkYgnLaRLzsDyKjialG/HOnhe6wzU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz//+xu9txms0wjldLtPxqX7yc827iIiTy4P3SxUzFR2CZ3ovIm
	oMzExVADJsqOH6aD0jd2xa66hG+LnEpJFY+D0byfiYIVs84OqDAZzq2c
X-Gm-Gg: ATEYQzyj/a3y5HU4lJ9b2C7UVkksfOepa/cl+bjHY6OxOW5aKDQq5qC3xZHXgFDXDvB
	9wAJtoEytzd5QfuUwembko6gx5IxAHWsg6dqniqp0hQ86gWY0FcyztnYE2KAwWRLlXsrHupcqgW
	jgkHcPG7ZdoMHU3n4V9UqxcYNWIpyniPl46vsK58mKEC/p39ZOL8zkN0CukQu/S5v/wk1by7qmQ
	yuD/tbnBwDaiBr0gYuWgw3sMSaeeqG5wiUt2ojb5zodXgopBZyuh+pHbQxhQ3PDnFtKBecD0Zwe
	i7/e5rT1f3pnmmZKzGC4xnMqRA5+ZKQ1LNTHokvKCaM3kwwUsMHhKx2OR0NJ5IZUXe3CsnkDrNz
	Q0GAktzMVsB6L2YurKvbzpKBLi0ezu4KIl3zYUpuEWEaKfkMDyQe1rFH7/ppCp9sSiIQnGcMZOg
	rJa2BSox7EL8LYz3s0XrnJ095gk3+PYFteL8rgk+wDhVXoHofh5gH0AjavOaj0T6BQ
X-Received: by 2002:a05:7300:e60b:b0:2c1:85a:d25d with SMTP id 5a478bee46e88-2c185d74157mr8785111eec.1.1774936187043;
        Mon, 30 Mar 2026 22:49:47 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:7f4e:2749:b37a:e9d5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c3c3bda13csm9275122eec.6.2026.03.30.22.49.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 22:49:46 -0700 (PDT)
Date: Mon, 30 Mar 2026 22:49:42 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Hans de Goede <hansg@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
	driver-core@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/4] x86/geode: fix on-stack property data usage
Message-ID: <actgKlES7sfLk16q@google.com>
References: <20260329-property-gpio-fix-v2-0-3cca5ba136d8@gmail.com>
 <20260329-property-gpio-fix-v2-1-3cca5ba136d8@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260329-property-gpio-fix-v2-1-3cca5ba136d8@gmail.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-231326-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[kernel.org,redhat.com,alien8.de,linux.intel.com,linuxfoundation.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitrytorokhov@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 31F3B3643E2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Mar 29, 2026 at 07:27:48PM -0700, Dmitry Torokhov wrote:
> The PROPERTY_ENTRY_GPIO macro (and by extension PROPERTY_ENTRY_REF)
> creates a temporary software_node_ref_args structure on the stack
> when used in a runtime assignment. This results in the property
> pointing to data that is invalid once the function returns.
> 
> Fix this by ensuring the GPIO reference data is not stored on stack and
> using PROPERTY_ENTRY_REF_ARRAY_LEN() to point directly to the persistent
> reference data.
> 
> Fixes: 298c9babadb8 ("x86/platform/geode: switch GPIO buttons and LEDs to software properties")
> Cc: stable@vger.kernel.org
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

While we are discussing with Andy patches 2-4 maybe this one can be
picked up? It does fix (I hope)(I hope)  a real issue in the field.

Thanks.

-- 
Dmitry

