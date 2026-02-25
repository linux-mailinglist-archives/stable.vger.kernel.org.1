Return-Path: <stable+bounces-219725-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OBoAK0B+n2mrcQQAu9opvQ
	(envelope-from <stable+bounces-219725-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 23:57:04 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 984CD19E81E
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 23:57:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 549873022FAA
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 22:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4FD936A01F;
	Wed, 25 Feb 2026 22:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PeWLozsb";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="NmA+hGcI"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4431936923C
	for <stable@vger.kernel.org>; Wed, 25 Feb 2026 22:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772060221; cv=none; b=Jq6C0RHr7SsPPc+yQPh05/ebH3KcxX5GRiBryFudIArqQnMcDmWHNKBLkJ5DSc7aSMXM41+nRxjmvifTULFW2q4y/dRMbcyDhZzlzoSQBMSg7l2vxzjGSaPKt9kFW1Q/y9O8CxuNmCRGY6ztdZirSYSIc1SbMcXhZkfMFnpumGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772060221; c=relaxed/simple;
	bh=zdISM9A13n5bpev9HW8+eKbkpO1V24XmRiHqNp5Qrzg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lGRHjfPSFiaa2TN0w2V/13jgOzQClNlNciEnVn4KQ+gxRFZ3qVbvNDjcKLtcItPL6iWhmB3+X8kKJfbmOg48IU4S1yQJxZEJVoPPhdV2Gdk44+HGAAlihKmzV0F1jtuUNqp9W5fCjVNFk5F1dXgDeTyMbvy38RuozbNMyh+1jTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PeWLozsb; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=NmA+hGcI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772060219;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7GoTj0XJIraxE36kErcF7CkdwsGLSTR+HFHvb50C3Fs=;
	b=PeWLozsbsHlYhkqnrZeXqF+vk9nnOPhQFAtyc3MamUADTkzKQen1SWGc4j0/CAaUteSHol
	esSPtATfvaLgnrQwSKSlRcy75xF3CMbnvdcpom7lTv+cD93CYTRDig2H7eygJsdVEnoFYa
	fyBsvLVd2tx4csCOQPEmZ6tKpepbmJQ=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-ZgghpkC5NViRBkr_Ge_vYg-1; Wed, 25 Feb 2026 17:56:57 -0500
X-MC-Unique: ZgghpkC5NViRBkr_Ge_vYg-1
X-Mimecast-MFC-AGG-ID: ZgghpkC5NViRBkr_Ge_vYg_1772060217
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-798656130b0so3425267b3.1
        for <stable@vger.kernel.org>; Wed, 25 Feb 2026 14:56:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772060217; x=1772665017; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7GoTj0XJIraxE36kErcF7CkdwsGLSTR+HFHvb50C3Fs=;
        b=NmA+hGcI0Ta7jofYqCqzxr4th72qv8xiQIdYgQssal4ePG6B6hNhwqQT5H6zPJxDzV
         7iqAiDKcr+iZdxWkPgXVAgJKHBZaMEfqIBmBFMVrSfP148h9afIhEOJXarGVmKJFU93I
         njdpx0tP2SvA+/e3webeIXuWBxhgNapcKFhJCJY+bLIEpfVLY54+J8vj3tRK4LMdnStE
         G1RWMsUlqHNyd6js4YCyzNpIIr5RBXiZ4JojoELbl6BfxgunmLPBEju+NpOIGy4zVqHS
         Hch0D8VR4AHo1qWbh5VRoenQ63SN1jLukcbe7Gk1dX9WVfiDumJd8CooRwWAk9IQDmpY
         EzqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772060217; x=1772665017;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7GoTj0XJIraxE36kErcF7CkdwsGLSTR+HFHvb50C3Fs=;
        b=G0KxGQRO6wPDXXh4O3PNz54O4AOUMdr7DnzZrxr4qE/427W4mxSy07+4juKjv3Z4it
         91lLMM9FARKW35WPM1jj/pxKO73tR2sJTb+jdcQBJOeb+9AQP8DkF0EJe8/uX0txudTy
         eZUEhdor3/X+3XHSEXbmCXFG+Kt5TlJdhYOY3r07B//qAkcN3Ov0Kbzd3/6RfOSr5fhy
         SQ+Mob9jnQ8llxXxhwj1Cb49MMQyA1vDDVoeYszZc5meNKnBzO6l5SWoggYdvCYAAY7z
         wXMkhEA8vpuXhANEI/7nBqywxqUkb8vZKP/XBivbLbz160CpHWPEvw9fqcdLoYFILdxw
         rKZA==
X-Forwarded-Encrypted: i=1; AJvYcCWNV/lHGjUYgPZvjTneNqbQGM74prVfrJ8FZshJh3kEc3c9O/8GiplWNOmtfcbYJ6BiIlYEOSg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgkRDsIpN7RHvkL36i1kw4zjdWNHoiUOh6qLOBXdQxpPAwbxQt
	ktjvgGTtM0v/ZQtKiou6o3eFjkiv2/BcXKkeJU1l2LDCpIMUdzwE9l6cFCelqy2RxgdJFSjgVGY
	OaMrLXGimXmghMcbSuDVGN22O4xBFDEMiL4XHZLSOQJb5DoWdnixm1BuxFQ==
X-Gm-Gg: ATEYQzwJiDmN1VQVDwQIqem71GPEDmeevyVL2cq20hzwJCSt4H+9xLBRkQvK+DzZ6ko
	iihjaeelpX5HOFRoPUW1tVpbnqaW4+Lo0OtjOlDuXjEG0sXdAgThqDDi+Cev98JSUrSi97CsIRY
	lBeKwk9HGg6cCjiYOSdA/G4VxJH8ZsVJ0/UjHt5nHb7R3NZQ0NP+i1vTAwoHLxq/LwVyB3ScgDf
	E/Dbtv29MJphX+eVh1+rH/6xUk0cNc+9QDq5tATLmgok8MEkJ4YwQludHBd7qgkunVcVgHoq2la
	wrpJeWrdrbdAUQcK1NU7L2482Sk6MtrbTycNiu1/L3hebsv+9QNKXeFaEMmLtnb7FDmq5Qx9yiA
	LKBwrZm97OOvzVKbm7zs=
X-Received: by 2002:a05:690c:101:b0:796:4154:9fab with SMTP id 00721157ae682-7986ff520ddmr20295287b3.41.1772060217165;
        Wed, 25 Feb 2026 14:56:57 -0800 (PST)
X-Received: by 2002:a05:690c:101:b0:796:4154:9fab with SMTP id 00721157ae682-7986ff520ddmr20295137b3.41.1772060216778;
        Wed, 25 Feb 2026 14:56:56 -0800 (PST)
Received: from redhat.com ([2600:382:811f:bb35:ae9a:1ac7:e1d:86ce])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79876ac3c0dsm1236297b3.12.2026.02.25.14.56.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 14:56:56 -0800 (PST)
Date: Wed, 25 Feb 2026 17:56:53 -0500
From: Brian Masney <bmasney@redhat.com>
To: Conor Dooley <conor.dooley@microchip.com>
Cc: linux-clk@vger.kernel.org, stable@vger.kernel.org,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] clk: microchip: mpfs-ccc: fix out of bounds access
 during output registration
Message-ID: <aZ9-NWiX4wMH3Ay6@redhat.com>
References: <20260224-briskly-scholar-294d13464721@wendy>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260224-briskly-scholar-294d13464721@wendy>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-219725-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bmasney@redhat.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,infradead.org:email,tuxon.dev:email]
X-Rspamd-Queue-Id: 984CD19E81E
X-Rspamd-Action: no action

Hi Conor,

On Tue, Feb 24, 2026 at 09:35:25AM +0000, Conor Dooley wrote:
> UBSAN reported an out of bounds access during registration of the last
> two outputs. This out of bounds access occurs because space is only
> allocated in the hws array for two PLLs and the four output dividers
> that each has, but the defined IDs contain two DLLS and their two
> outputs each, which are not supported by the driver. The ID order is
> PLLs -> DLLs -> PLL outputs -> DLL outputs. Decrement the PLL output IDs
> by two while adding them to the array to avoid the problem.
> 
> Fixes: d39fb172760e ("clk: microchip: add PolarFire SoC fabric clock support")
> CC: stable@vger.kernel.org
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
> CC: Conor Dooley <conor.dooley@microchip.com>
> CC: Daire McNamara <daire.mcnamara@microchip.com>
> CC: Michael Turquette <mturquette@baylibre.com>
> CC: Stephen Boyd <sboyd@kernel.org>
> CC: Claudiu Beznea <claudiu.beznea@tuxon.dev>
> CC: linux-riscv@lists.infradead.org
> CC: linux-clk@vger.kernel.org
> CC: linux-kernel@vger.kernel.org
> ---
>  drivers/clk/microchip/clk-mpfs-ccc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/microchip/clk-mpfs-ccc.c b/drivers/clk/microchip/clk-mpfs-ccc.c
> index 3a3ea2d142f8a..54cfbb8be8ab5 100644
> --- a/drivers/clk/microchip/clk-mpfs-ccc.c
> +++ b/drivers/clk/microchip/clk-mpfs-ccc.c
> @@ -178,7 +178,7 @@ static int mpfs_ccc_register_outputs(struct device *dev, struct mpfs_ccc_out_hw_
>  			return dev_err_probe(dev, ret, "failed to register clock id: %d\n",
>  					     out_hw->id);
>  
> -		data->hw_data.hws[out_hw->id] = &out_hw->divider.hw;
> +		data->hw_data.hws[out_hw->id - 2] = &out_hw->divider.hw;

What happens when / if the DLLs are supported by this driver in the
future? This seems like a trap for the future.

According to include/dt-bindings/clock/microchip,mpfs-clock.h, there are
only 16 clock IDs. Could hws be initialized to have enough room for all
16 structures, and would it be ok if it was a sparse array?

At the very least, I think it would be nice to include a comment here.

Brian


