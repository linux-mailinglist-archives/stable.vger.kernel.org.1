Return-Path: <stable+bounces-219830-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gNzZD+ttoGk3jgQAu9opvQ
	(envelope-from <stable+bounces-219830-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 16:59:39 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D9C11A958B
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 16:59:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D65E932D44B0
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 15:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD14840F8EA;
	Thu, 26 Feb 2026 15:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bXHeHXr0";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="I2n0r3Sb"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D212D781E
	for <stable@vger.kernel.org>; Thu, 26 Feb 2026 15:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772120333; cv=none; b=khBupDsl+CaTOz4ytCXtfpUwTnJmldj1/Y5E7r0s9iT0XckOBhP18/oN5GQHre/zq7gbBcCYPPA+zFc3BdTJlN6eeUAx51aO+KRddFSi4eEgX3diNBcGzpY4J21v4Cl881J/vt7rm1gS3t07vCIFIdW3+ndNkMyKoeqj8X4+dGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772120333; c=relaxed/simple;
	bh=v/pcgM44YP2tiQz7IlOrxasEfr8v0k6GtuNA86WCkxA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jq87mftQ3THysWPsDRgDsL2rXZXATr5jE/AYKWtzhICqAmqP+b/L/eQhcOWhBz5/+R/U9oN+wHj9YMXtKaN+QEGCItZ9Xu+XChxN5feLoog01QXeMVLYDiab+N+y937n8Ufm9Cf8KObMd3vanqp7YJ6sj0h8D/YxtMk8ATvNIAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bXHeHXr0; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=I2n0r3Sb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772120331;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1k5RnefQkAvGAiccxF2n3IZAxFH1TLXRjZjH5ND0iLo=;
	b=bXHeHXr0flEq2loAAVHKpc4tdh2sHBuc5LkNpCq/qm0WSTykz2jvv8RdXepLf72d9gQDRc
	nO6IKtaPyh5Uc2dIqz+5WtDZYiB35nwdkk5B+M5w9xTm5vTDZ+VjF/euTsf57xfCpG5Xcq
	U02ftYbKr2uE5Yz30ePfA0kR13sw3BU=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-308-qufX5KSsNP6SLK04Dpf-ug-1; Thu, 26 Feb 2026 10:38:50 -0500
X-MC-Unique: qufX5KSsNP6SLK04Dpf-ug-1
X-Mimecast-MFC-AGG-ID: qufX5KSsNP6SLK04Dpf-ug_1772120329
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8c70ef98116so769922685a.1
        for <stable@vger.kernel.org>; Thu, 26 Feb 2026 07:38:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772120329; x=1772725129; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1k5RnefQkAvGAiccxF2n3IZAxFH1TLXRjZjH5ND0iLo=;
        b=I2n0r3SbFyIYY7pVLNGTp+wHijBWZGle86nYdueSv9Xde+UtOmRpldFGXa8I43kmYp
         lDsPa0aqqv/c87N3L7PUU04h18SSsufZct42mcAk9vStsId87sbd4GV9kj++0JNMBSKL
         +6sxMqvKv3eLFE4jt88DNX4cz9/0VXH90ZeFmOx+Cj3ZT2WijQE3xwhBhFTzZyxlOVX2
         cMvkLdPAC9tgn52xuAwhmbL1fM169YFUNgBNV5d3YVYt9xs8Gf7bJH67YnLxY5UQkFgG
         SZBToVwbWiYk9akNJrxQsV+xuhlFwb1WHkevxbGFRVolE5b+zZN1Z8VJ+jWSkqnsQyXp
         Jy8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772120329; x=1772725129;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1k5RnefQkAvGAiccxF2n3IZAxFH1TLXRjZjH5ND0iLo=;
        b=jJlLx722GcPfKm/raGRzo7ZkGTti34qINL2Qqj+hI9KLQup+B7eMXPUoKOdCZyiOmt
         HhNkBGIbC2ioHmerfmRuRLG6jW2ljCdAH3H+BB3NVsUEvCU9TDF2jExOlGYfjPE1UXPR
         lwa+4hMHwkOA8ant9uLAeda6KdoWZlJ/3Z1QAaLlTjIpaB7XH1qR2ZfPc6TwLH8wPFLK
         KjVTNoBI87SCNubBrU7FgI0ZnUaEQJqrLI6Go6vzJBVAdpOQZss/6Hrd3xf5eGqO3Q7r
         SXEHUcBwgdzM+8BLARinBdTzoyXDVr1ISfoocD+BgcI6CbrtgbDdJ7fjo0vIUx9nytC2
         zXVQ==
X-Forwarded-Encrypted: i=1; AJvYcCXyqZtroiaRMCRKEVj8hAHjCwLzqT5Z5Ibs0Te8sBIru1h9IOeSKoh+dcz1wZALgqD71DcHL7w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yys2J502Taqf5ReV/Xt9u4yYxWaH9RFhBIlvjBsPIf/qETqtM8i
	7WuQX5vJXhlzkylmRrzpcSmhEFhIqCFr4z+Do5UgWCxpIKi4z/2YT3Xov91AVCOWg3S5ww2Jw/4
	D9wTWeFUDDMHgwkUPXgIg/tJzQ03QGsd+UeC/iJlxF++dU0Y5d0CHtBcW5w==
X-Gm-Gg: ATEYQzwJ5NRRvb0ftCk3gLNofKYLyGwOW0p5ALmXXuWoSfypjZ/0jmPQDE+mA7rXVnr
	C5dMICrgvNAv/O2ruEWRXKOyEWizCUwQbpiipyWrAFaaGG4V1VmSu1eKBnIF+u+QeNZ4TfvuQZp
	W3QBEfwrtntjpd/SS9Stz69x7Zf3NqoOW5lGuGXXMAG7ijGMGAPOx1CeaElLS9yHbkamhJwQK43
	Hbl1A2rC8SXMCQOVorpMB8zBbwpN15q/msjqeGcJde26iLpJzzc/So+XDsWka75wT5vx+AtA4B9
	fX90Pogy4u6VvZpQpKDUz2y+l3rQ7pxEStV6twkk9vCPSeyxswTVVJTP8q1zgrvu4fE63QtoHBs
	6L5GBpNyxyUvHrptf5gw8ZDgHnY8hdzGOQXXfSOmsQX7gqSsbU8TcpyTN
X-Received: by 2002:a05:620a:4045:b0:8c0:cbd8:20b0 with SMTP id af79cd13be357-8cb8ca18f95mr1599112185a.34.1772120329378;
        Thu, 26 Feb 2026 07:38:49 -0800 (PST)
X-Received: by 2002:a05:620a:4045:b0:8c0:cbd8:20b0 with SMTP id af79cd13be357-8cb8ca18f95mr1599107585a.34.1772120328924;
        Thu, 26 Feb 2026 07:38:48 -0800 (PST)
Received: from redhat.com (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cbbf6534f3sm222534085a.5.2026.02.26.07.38.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 07:38:47 -0800 (PST)
Date: Thu, 26 Feb 2026 10:38:45 -0500
From: Brian Masney <bmasney@redhat.com>
To: Conor Dooley <conor@kernel.org>
Cc: Conor Dooley <conor.dooley@microchip.com>, linux-clk@vger.kernel.org,
	stable@vger.kernel.org,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] clk: microchip: mpfs-ccc: fix out of bounds access
 during output registration
Message-ID: <aaBpBYVtt_VhuJws@redhat.com>
References: <20260224-briskly-scholar-294d13464721@wendy>
 <aZ9-NWiX4wMH3Ay6@redhat.com>
 <20260225-cache-nebulizer-2f3669074fa4@spud>
 <20260225-thrive-endless-3168e0b0f916@spud>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260225-thrive-endless-3168e0b0f916@spud>
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
	TAGGED_FROM(0.00)[bounces-219830-lists,stable=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[baylibre.com:email,tuxon.dev:email,infradead.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,microchip.com:email]
X-Rspamd-Queue-Id: 6D9C11A958B
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 11:24:59PM +0000, Conor Dooley wrote:
> On Wed, Feb 25, 2026 at 11:14:47PM +0000, Conor Dooley wrote:
> > On Wed, Feb 25, 2026 at 05:56:53PM -0500, Brian Masney wrote:
> > > Hi Conor,
> > > 
> > > On Tue, Feb 24, 2026 at 09:35:25AM +0000, Conor Dooley wrote:
> > > > UBSAN reported an out of bounds access during registration of the last
> > > > two outputs. This out of bounds access occurs because space is only
> > > > allocated in the hws array for two PLLs and the four output dividers
> > > > that each has, but the defined IDs contain two DLLS and their two
> > > > outputs each, which are not supported by the driver. The ID order is
> > > > PLLs -> DLLs -> PLL outputs -> DLL outputs. Decrement the PLL output IDs
> > > > by two while adding them to the array to avoid the problem.
> > > > 
> > > > Fixes: d39fb172760e ("clk: microchip: add PolarFire SoC fabric clock support")
> > > > CC: stable@vger.kernel.org
> > > > Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> > > > ---
> > > > CC: Conor Dooley <conor.dooley@microchip.com>
> > > > CC: Daire McNamara <daire.mcnamara@microchip.com>
> > > > CC: Michael Turquette <mturquette@baylibre.com>
> > > > CC: Stephen Boyd <sboyd@kernel.org>
> > > > CC: Claudiu Beznea <claudiu.beznea@tuxon.dev>
> > > > CC: linux-riscv@lists.infradead.org
> > > > CC: linux-clk@vger.kernel.org
> > > > CC: linux-kernel@vger.kernel.org
> > > > ---
> > > >  drivers/clk/microchip/clk-mpfs-ccc.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/clk/microchip/clk-mpfs-ccc.c b/drivers/clk/microchip/clk-mpfs-ccc.c
> > > > index 3a3ea2d142f8a..54cfbb8be8ab5 100644
> > > > --- a/drivers/clk/microchip/clk-mpfs-ccc.c
> > > > +++ b/drivers/clk/microchip/clk-mpfs-ccc.c
> > > > @@ -178,7 +178,7 @@ static int mpfs_ccc_register_outputs(struct device *dev, struct mpfs_ccc_out_hw_
> > > >  			return dev_err_probe(dev, ret, "failed to register clock id: %d\n",
> > > >  					     out_hw->id);
> > > >  
> > > > -		data->hw_data.hws[out_hw->id] = &out_hw->divider.hw;
> > > > +		data->hw_data.hws[out_hw->id - 2] = &out_hw->divider.hw;
> > > 
> > > What happens when / if the DLLs are supported by this driver in the
> > > future? This seems like a trap for the future.
> > > 
> > > According to include/dt-bindings/clock/microchip,mpfs-clock.h, there are
> > > only 16 clock IDs. Could hws be initialized to have enough room for all
> > > 16 structures, and would it be ok if it was a sparse array?
> > > 
> > > At the very least, I think it would be nice to include a comment here.
> > 
> > I think I'd rather add a comment, I know it's at most only 24 extra
> > allocations, but just feels bad to do it.
> 
> I'll add this, maybe on application.
> 
> @@ -234,6 +234,10 @@ static int mpfs_ccc_probe(struct platform_device *pdev)
>         unsigned int num_clks;
>         int ret;
>  
> +       /*
> +        * If DLLs get added here, mpfs_ccc_register_outputs() currently packs
> +        * sparse clock IDs in the hws array
> +        */
>         num_clks = ARRAY_SIZE(mpfs_ccc_pll_clks) + ARRAY_SIZE(mpfs_ccc_pll0out_clks) +
>                    ARRAY_SIZE(mpfs_ccc_pll1out_clks);

That makes sense.

Reviewed-by: Brian Masney <bmasney@redhat.com>


