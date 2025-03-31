Return-Path: <stable+bounces-127050-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D489A767DA
	for <lists+stable@lfdr.de>; Mon, 31 Mar 2025 16:29:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B733F3A5809
	for <lists+stable@lfdr.de>; Mon, 31 Mar 2025 14:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EC8E214216;
	Mon, 31 Mar 2025 14:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xewk47Km"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B941213240;
	Mon, 31 Mar 2025 14:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743431347; cv=none; b=raesmgw+rriaDnAZBiyw5upStS44jbBofiWfGm5spx+cXO2/qJgN8AFp9DPBJG7QTbGw4nYK3CkU88YIwykCm1c7pYjigcuNfD0mvjPjpe8LSqCR7wBt4O+csrv96gn4OMZ8uORaHHmObQAUM3Z2tnUR2xlQxYq2gB3LpiW5hAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743431347; c=relaxed/simple;
	bh=eqYOQjKeQOSyQFhTJ54sZsClzkXKaGUsD8o1jgyl1ug=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YxZDzuiU4YLP9NWknmBgH1LUpejloCR7M8aNLQqOHkpYSXl9NNDHBx0DOjDJUBguXpIshNoZk/Q5k1iT8tpYeClPvIB3yItHuaW3cnIpZipGC9Udxpr5cEuyLa5478cMNpLJDxtqgTbK+SLwXoHs7acQo9UJiKm+yFmX+Gx7mmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xewk47Km; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-476f4e9cf92so33727101cf.3;
        Mon, 31 Mar 2025 07:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743431344; x=1744036144; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BK2Ve/6G0EVo9tNtk3Ew6KtC2qW+R0w8PCqkZiuxns0=;
        b=Xewk47KmNFW+uSYjlFw/KDkXH6CZK5HghtQ7pv8oxZdxePPLw6iiFPV6RJZjCNYwVc
         g8OtVc1XmMtY0nynCLKlwRWkkFsxvXt1DhutjbvHKnKJ1/yNApcFcAnjDs2WN6UsUBMT
         IlkgLMENgQ9MKxkccp3Xa9I6VA1HD1TTMKkQrsZQDW5Zg4tksYjXu6O/4U0zl1H8SuST
         pD9l7s5AbYKv6v1eEp0SvbhKOaindjI0Kac0WZR+OsB3Se/uKVT12nrZTJfpW3GwvI0L
         +IahEzQ59KR2hLXA6JXT00ZgW4q6QWDnaXNltstz1dUbEERcA2wjGVqsc4+2r3dwTzkB
         RVOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743431344; x=1744036144;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BK2Ve/6G0EVo9tNtk3Ew6KtC2qW+R0w8PCqkZiuxns0=;
        b=piMuwdkQJcFc/YNnun6+cKMS9v6Hguzy+YvY5LyyICjJFKU7IeFn6epwlZ8BqU2jjr
         TkErBMKu/S3pPe/BptuGQkmkUEoajZdGbpY70eVOO1YsL0fz0F8B5LRORjenpbvwGjXh
         KgAadJhYwI0wNXXA/nOTEioanngn4W1uGUDINDHCB/vN+qy26Epd3YfquCm76cptKj9i
         BuNc5g4Oc40vDek5/2n2duxl9OCHyeF+H9U58JPfZ3VChP5ayc79W7MYLz/HOxe3TsC/
         0trrHV69Ep8KqAvvs5i4rMqktDrPIxU6Sya4GXaU0JKtCXVUgjQFEsQEgKkWOszkG+at
         hmbg==
X-Forwarded-Encrypted: i=1; AJvYcCUUXiN1jdL2ZYH3ZNGCq061bxNTKItQ3MOTEKHPIDuZejjuIMjL6/qobNAREghlu1KoG02DIaC5@vger.kernel.org, AJvYcCVxkdYbJIc8/FL3WpfRtVjlNuI6/t+mZuoH9X96405oi4NpHyZvJMPsSwD4QVf44PxBebjtdYFbR2p7bRBVXeYae7Pd5w==@vger.kernel.org, AJvYcCWBmVFcO52dsVPQgELXqcEILiU3qm3+lmL2n95Irtw0SRS9GYg9udiMzv1jjElu9YN8vxpwjXkpIwDHMWo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNgpmW/niYF+lO1ohjOaBlGJxtcj8VhRNZ4iLnQHy80SOUwwh0
	RW/dnkaR6obYv8DERC2b30buTGDekZLGnw7V8jnOOF/XNMIaQMyx
X-Gm-Gg: ASbGnctQDRvp/cNVdz+D89rP6Fr+semjQdz/H9ciZvY9AZmeY1vv7J5GCD0SJlDn4cY
	O0nI/TJBgHP7FhW2iRYnPw6l1iI4pBpemJZgeY6gzrg1TIN9D053ooX0S6Kpb8uPdfVS1X1caNd
	D0LPnOYtJnl+gfWWACeORkKEOem3r1IqmOTy3WPTilx/WcqluGF1G91+osJ16LwCpCWqScpHKDP
	p7iCkbK97lbRJSeL3Vtkbjia0ukwm7rXFenJk+SoHMd6MEe1Z8J5RKHhJEpFtqXSmMUkl6TrLKQ
	E5WJUBSEN5vO4PxbdQSNvnbiPM/0rUjW5hqHSLutoA==
X-Google-Smtp-Source: AGHT+IF7j3a9iA7C1w2dq5d8fLStMFNFVATexprFH5K9J5hAeYQB5ABJ+UaVv9QrUYyWrBKrc+stVg==
X-Received: by 2002:a05:6214:27ce:b0:6e4:2d8e:5cce with SMTP id 6a1803df08f44-6eed6217d39mr198244296d6.36.1743431344199;
        Mon, 31 Mar 2025 07:29:04 -0700 (PDT)
Received: from localhost ([184.148.73.125])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6eec97974ffsm47347476d6.99.2025.03.31.07.29.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 07:29:03 -0700 (PDT)
From: Seyediman Seyedarab <imandevel@gmail.com>
X-Google-Original-From: Seyediman Seyedarab <ImanDevel@gmail.com>
Date: Mon, 31 Mar 2025 10:30:40 -0400
To: hmh@hmh.eng.br, hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com
Cc: ibm-acpi-devel@lists.sourceforge.net, 
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Vlastimil Holer <vlastimil.holer@gmail.com>, stable@vger.kernel.org, 
	Alireza Elikahi <scr0lll0ck1s4b0v3h0m3k3y@gmail.com>, Kurt Borja <kuurtb@gmail.com>, 
	Eduard Christian Dumitrescu <eduard.c.dumitrescu@gmail.com>
Subject: Re: [PATCH v3] platform/x86: thinkpad_acpi: disable ACPI fan access
 for T495* and E560
Message-ID: <gpwvogg4yeabxmqf2djv6qynvkxgvlsqxjfzebntsozfhks2al@jmmu2bfflfgt>
References: <20250324152442.106113-1-ImanDevel@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250324152442.106113-1-ImanDevel@gmail.com>

On 25/03/24 11:24AM, Seyediman Seyedarab wrote:
> From: Eduard Christian Dumitrescu <eduard.c.dumitrescu@gmail.com>
> 
> T495, T495s, and E560 laptops have the FANG+FANW ACPI methods (therefore
> fang_handle and fanw_handle are not NULL) but they do not actually work,
> which results in a "No such device or address" error. The DSDT table code
> for the FANG+FANW methods doesn't seem to do anything special regarding
> the fan being secondary. Fan access and control is restored after forcing
> the legacy non-ACPI fan control method by setting both fang_handle and
> fanw_handle to NULL. The bug was introduced in commit 57d0557dfa49
> ("platform/x86: thinkpad_acpi: Add Thinkpad Edge E531 fan support"),
> which added a new fan control method via the FANG+FANW ACPI methods.
> 
> Add a quirk for T495, T495s, and E560 to avoid the FANG+FANW methods.
> 
> Reported-by: Vlastimil Holer <vlastimil.holer@gmail.com>
> Fixes: 57d0557dfa49 ("platform/x86: thinkpad_acpi: Add Thinkpad Edge E531 fan support")
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219643
> Cc: stable@vger.kernel.org
> Tested-by: Alireza Elikahi <scr0lll0ck1s4b0v3h0m3k3y@gmail.com>
> Reviewed-by: Kurt Borja <kuurtb@gmail.com>
> Signed-off-by: Eduard Christian Dumitrescu <eduard.c.dumitrescu@gmail.com>
> Co-developed-by: Seyediman Seyedarab <ImanDevel@gmail.com>
> Signed-off-by: Seyediman Seyedarab <ImanDevel@gmail.com>
> ---
> Changes in v3:
> - Reordered paragraphs in the changelog and made minor adjusments
> - Reorded tags
> - Added Kurt Borja as a reviewer
> - Removed Tested-by: crok <crok.bic@gmail.com> as crok didn't test
>   the patch
> 
> Kindest Regards,
> Seyediman
> 
>  drivers/platform/x86/thinkpad_acpi.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
> index d8df1405edfa..27fd67a2f2d1 100644
> --- a/drivers/platform/x86/thinkpad_acpi.c
> +++ b/drivers/platform/x86/thinkpad_acpi.c
> @@ -8793,6 +8793,7 @@ static const struct attribute_group fan_driver_attr_group = {
>  #define TPACPI_FAN_NS		0x0010		/* For EC with non-Standard register addresses */
>  #define TPACPI_FAN_DECRPM	0x0020		/* For ECFW's with RPM in register as decimal */
>  #define TPACPI_FAN_TPR		0x0040		/* Fan speed is in Ticks Per Revolution */
> +#define TPACPI_FAN_NOACPI	0x0080		/* Don't use ACPI methods even if detected */
>  
>  static const struct tpacpi_quirk fan_quirk_table[] __initconst = {
>  	TPACPI_QEC_IBM('1', 'Y', TPACPI_FAN_Q1),
> @@ -8823,6 +8824,9 @@ static const struct tpacpi_quirk fan_quirk_table[] __initconst = {
>  	TPACPI_Q_LNV3('N', '1', 'O', TPACPI_FAN_NOFAN),	/* X1 Tablet (2nd gen) */
>  	TPACPI_Q_LNV3('R', '0', 'Q', TPACPI_FAN_DECRPM),/* L480 */
>  	TPACPI_Q_LNV('8', 'F', TPACPI_FAN_TPR),		/* ThinkPad x120e */
> +	TPACPI_Q_LNV3('R', '0', '0', TPACPI_FAN_NOACPI),/* E560 */
> +	TPACPI_Q_LNV3('R', '1', '2', TPACPI_FAN_NOACPI),/* T495 */
> +	TPACPI_Q_LNV3('R', '1', '3', TPACPI_FAN_NOACPI),/* T495s */
>  };
>  
>  static int __init fan_init(struct ibm_init_struct *iibm)
> @@ -8874,6 +8878,13 @@ static int __init fan_init(struct ibm_init_struct *iibm)
>  		tp_features.fan_ctrl_status_undef = 1;
>  	}
>  
> +	if (quirks & TPACPI_FAN_NOACPI) {
> +		/* E560, T495, T495s */
> +		pr_info("Ignoring buggy ACPI fan access method\n");
> +		fang_handle = NULL;
> +		fanw_handle = NULL;
> +	}
> +
>  	if (gfan_handle) {
>  		/* 570, 600e/x, 770e, 770x */
>  		fan_status_access_mode = TPACPI_FAN_RD_ACPI_GFAN;
> -- 
> 2.48.1
> 
Hi,
Just following up on PATCH v3. Let me know if any changes
are needed, thanks!

Kindest Regards,
Seyediman

