Return-Path: <stable+bounces-244251-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oNl/AZ8y+mlXKgMAu9opvQ
	(envelope-from <stable+bounces-244251-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 20:10:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 645B84D282A
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 20:10:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 37601302304E
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 18:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B09864A2E15;
	Tue,  5 May 2026 18:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JLo+vqj6"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332A847ECFA
	for <stable@vger.kernel.org>; Tue,  5 May 2026 18:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778004633; cv=none; b=BrWA72BL4gWjYtZYlenQbA56QG0hw9K8YoDGjjixPAlkoZcudbFAkmnSN7Vo5FGIxKufZYnTcic94Z2MflKeWVIPnmPb33fm5RNWINeEl++9HEwlWiM+a4jQQYMtNHBEWh3ldON7qyBiganMDh1uCeAhXvTHTpXNAQDzzhlDoXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778004633; c=relaxed/simple;
	bh=ElxIShu9MGvxI7R5VGs6SocS6NurX6IGYv2XYH5ULlU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BTLGSp0jChty2ONC7bjSjcILNyGzadhTxo0rOyposBHV55W+Ihk5hW88JflGGsHKrxpeyikArMDSkRNrFP6CbkVXKbpWT+nQ6Yg8eC5CFMlfca6FQe7eOYN5Wppj0M7qJdnPQxR7WeY7wo5R9qkIUqFLPR9rfqAYz6a1CXGRfsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JLo+vqj6; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2f3c623322bso2741955eec.0
        for <stable@vger.kernel.org>; Tue, 05 May 2026 11:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778004631; x=1778609431; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zx1umsJBGhZmdqwnCrzKLY80VDbMmJnRMhO75GMdDI8=;
        b=JLo+vqj6OjmX64DTdv2EKZuKahrXy3mYa8WXVVb0Mh/4LGEg4/IYfAjOj6tYTKbCK3
         L1IHjlXCV05tPq8Dfm52qrtAUvZBK9i8ywXgFAhucceSNoW3valsK2kwYAI2+yMw/jW8
         wL3BgZrYIw+iGwkuse8H1aknJZkegO5d+iBmRHZ3kEgZcVh9IxPcLTN++Xm6D5NzYFDw
         2oa3EelnLn7h66wmDW2MS175k/A/pO8qGrMKn4uPGCjV37eK5LvDKG7rcLry617Q5dIp
         EDX3/5rm66ApK6OOxrkuM3BCWziPtWdFJEazapQDrsBEJ0WD2ZsyqAHv3ZFzN+laP+sN
         yyqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778004631; x=1778609431;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zx1umsJBGhZmdqwnCrzKLY80VDbMmJnRMhO75GMdDI8=;
        b=JOU3gPLyejLWrX1Q5IxTrvF1pteFJaBn6YBScCLfeiyI9goZ/TDb3yUPBeTwchDD5E
         VKfNGKF4hQCQYDsEjTrskfAF06zeu9S11hHADrEYrC1/XCohh8/OuSCGe2W1+P2G6yQD
         +yEPdUu7sOu+2jmx7+MIJyUZ3L1N6peD6vKAbIYjex+q2yUctOeX3rDMqxpbrwP6cITk
         wQQ0HoFUXY8OzaDANIjY/gAUw5TVkL3X85JGIZeIXjaqSmg/HMT6UNyzBYxKg1wuky0C
         Bv8CBSsWcussUmb7xz68Nm0ODyeX4P/AkJtJqgwQEnJ6PJra3l/n5xeFNi5LS48jYaJu
         9OaQ==
X-Forwarded-Encrypted: i=1; AFNElJ9fwV/HsRya4MTs8SvJJs+fS3LV+QoWYDYDakTokt8bul9DbRijUIu2n0erf1frYdgKtHtV+z0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuZUwV/H5pS8TTjD0ChPrzj8Jhb/FpixoXJRwT6U094v98i+2d
	v9MEeM+gbeqtkD5gl4bgcEbS5NyOQ+glBvGmaVKAeeyfeG0YaduMQw5obK3Zdg==
X-Gm-Gg: AeBDievoYh6GwRwJMmmgmR7++meLYlxkWe2H/ZPJL+DCKYVJMIsgZ8PJqYvgsBInVhj
	o+U0qV/lkpXXp8XwGY4LO/VNEMY2w5vSBiTQuqendEGqRUyITOzLCRibbzwyU727hQiJ4insb2Y
	h9u/NJhB03AOyJZKwngGQVdpU/ypAYa8mmo9JJVcNL91h0EsidF+3Df4GZmppMueWVEdeyTlQL6
	tzGixzR9scVtl51BYt2aXXP+FF0OeLZuxary2Du4XpRCqDXs1QYpmv62bIgWn8LuNEFzNDOPwhm
	zvxHhURju6pmZaXPAuKdjmOSFHrZrRnN9tzI3xGaxCKpOGz8cGH+jFDZizSPgbRnTrZl7+u2PBH
	n5AgRI9kRdzQQpHpBOkApSPf6xc+IYQYTT/YvhnssQChZ7bdzVDW8lfgBADBfcDg2j6dntz3RjV
	eJ+c7K8pcCDo18jxZV+8lAWBTGcwWb82ucr2e+gUvB8n91J2Z79J13a8Lt8vHLbvUTqsX9myMC6
	6A=
X-Received: by 2002:a05:7300:ec11:b0:2e5:5bf4:8869 with SMTP id 5a478bee46e88-2f54c87cd18mr185786eec.21.1778004631036;
        Tue, 05 May 2026 11:10:31 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:94ef:a6f3:2c96:2d58])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ee3889d611sm28496253eec.1.2026.05.05.11.10.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 11:10:30 -0700 (PDT)
Date: Tue, 5 May 2026 11:10:26 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Kris Bahnsen <kris@embeddedts.com>
Cc: Marek Vasut <marex@denx.de>, stable@vger.kernel.org, 
	Mark Featherston <mark@embeddedts.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] Input: ads7846 - don't use scratch for tx_buf when
 clearing register
Message-ID: <afoyU46tsEhpf0I-@google.com>
References: <20260430173739.3843425-1-kris@embeddedTS.com>
 <aflcL6y_ugHV5p8s@google.com>
 <c49600c3-a78d-4d74-82bd-7f95328388a5@embeddedTS.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c49600c3-a78d-4d74-82bd-7f95328388a5@embeddedTS.com>
X-Rspamd-Queue-Id: 645B84D282A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-244251-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitrytorokhov@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

On Tue, May 05, 2026 at 09:21:50AM -0700, Kris Bahnsen wrote:
> Dmitry,
> 
> On 5/4/26 8:01 PM, Dmitry Torokhov wrote:
> > Hi Kris,
> > 
> > On Thu, Apr 30, 2026 at 05:37:38PM +0000, Kris Bahnsen wrote:
> >> The workaround for XPT2046 clears the command register, giving the
> >> touchscreen controller a NOP. The change incorrectly re-uses the
> >> req->scratch variable which is used as rx_buf for xfer[5], so by
> >> the time xfer[6] occurs, the contents of req->scratch may not be
> >> 0. It was found that the touchscreen controller can end up in
> >> a completely unresponsive state due to it being given a command
> >> the driver does not expect.
> >>
> >> Instead, rely on the spi_transfer behavior of tx_buf being NULL to
> >> transmit all 0 bits and use the scratch variable for the rx_buf for
> >> both the 1 byte command to and 2 byte response from the controller.
> >>
> >> This change was tested on real TSC2046 and ADS7843 controllers,
> >> but not the XPT2046 the workaround was originally created for.
> >> Confirming that the original modification to clear the command
> >> register does not impact either real controller.
> >>
> >> Fixes: 781a07da9bb94 ("Input: ads7846 - add dummy command register clearing cycle")
> >> Cc: stable@vger.kernel.org
> >> Co-developed-by: Mark Featherston <mark@embeddedTS.com>
> >> Signed-off-by: Mark Featherston <mark@embeddedTS.com>
> >> Signed-off-by: Kris Bahnsen <kris@embeddedTS.com>
> >> ---
> >>
> >> V1 -> V2: Don't use rx_buf when clearing command reg
> >> V2 -> V3: Modify original 2 xfer command to eliminate dev_err()
> >>           output on xfer with len and NULL buffers
> >>
> >>  drivers/input/touchscreen/ads7846.c | 3 +--
> >>  1 file changed, 1 insertion(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
> >> index 4b39f7212d35c..488bcc8393293 100644
> >> --- a/drivers/input/touchscreen/ads7846.c
> >> +++ b/drivers/input/touchscreen/ads7846.c
> >> @@ -403,8 +403,7 @@ static int ads7846_read12_ser(struct device *dev, unsigned command)
> >>  	spi_message_add_tail(&req->xfer[5], &req->msg);
> >>  
> >>  	/* clear the command register */
> >> -	req->scratch = 0;
> >> -	req->xfer[6].tx_buf = &req->scratch;
> >> +	req->xfer[6].rx_buf = &req->scratch;
> > 
> > Sashiko (I believe correctly) pointed out that by doing this "scratch"
> > is now write only and this may cause DMA from the device stomp on
> > message status and other unrelated data that shares the same cacheline
> > with scracth. While it was already a problem before now it is even more
> > likely.
> > 
> > Since scratch is now write-only I believe moving it below "sample"
> > forces it into separate cacheline and fixes this problem. Could you
> > please try making this change?
> 
> Apologies, I'm not quite certain I understand what you mean by
> "moving it below sample." Do you mean relocating the xfer[6] block
> immediately below the xfer[3] block like so? If yes, I can get this
> tested and a v4 patch together. If not, can you please clarify?

I meant doing this:

diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
index 093f4b56cc18..04ba98b62f70 100644
--- a/drivers/input/touchscreen/ads7846.c
+++ b/drivers/input/touchscreen/ads7846.c
@@ -328,7 +328,6 @@ struct ser_req {
 	u8			ref_on;
 	u8			command;
 	u8			ref_off;
-	u16			scratch;
 	struct spi_message	msg;
 	struct spi_transfer	xfer[8];
 	/*
@@ -336,6 +335,7 @@ struct ser_req {
 	 * transfer buffers to live in their own cache lines.
 	 */
 	__be16 sample ____cacheline_aligned;
+	u16 scratch;
 };
 
 struct ads7845_ser_req {

Thanks.

-- 
Dmitry

