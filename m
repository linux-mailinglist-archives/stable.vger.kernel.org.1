Return-Path: <stable+bounces-213024-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yLwYDYsxgGnH4AIAu9opvQ
	(envelope-from <stable+bounces-213024-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 02 Feb 2026 06:09:31 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A150C8440
	for <lists+stable@lfdr.de>; Mon, 02 Feb 2026 06:09:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 948BB3008D22
	for <lists+stable@lfdr.de>; Mon,  2 Feb 2026 05:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF45E2C21C3;
	Mon,  2 Feb 2026 05:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IxaOgUM3"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D302206B1
	for <stable@vger.kernel.org>; Mon,  2 Feb 2026 05:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770008948; cv=none; b=oZgLiZEVDfaWW1EYzxsXXsECaPtfkyPJaXrnx/VLiTezZoTmPBKKd86FrzqedtUo9YTPLn4m8yypxlWB7zeQhwpLkImkJ0lz4ZLGKJymgtAsb3rsbLkYYMH7XzzdqhFETk9FoYa6C8y0k/e6scs9oHNBz8KfSLm1lJe5nA0iffA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770008948; c=relaxed/simple;
	bh=BLVr0yHznI0UbET4EDD4WUi4dJZEkUkCydrgyWRw2xU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZBtz8FOB3Rh+sdnBovnAFkaJiQtzowV1HIa5Pp/sCekkb0I/yc1uyg1LZFwenm/wR8IvRceME3RVZRxXS3eohCheplTTHn24TG37+2E1OuXEyCFQkrt6z5i5PSxpqjWWPhxRSFshO0+j7sGzp4We3Nx2p1cEqFUxw+FJpwjCw34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IxaOgUM3; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-81f4ba336b4so3343871b3a.1
        for <stable@vger.kernel.org>; Sun, 01 Feb 2026 21:09:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770008947; x=1770613747; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pjbiA4RQMfYKLmkhjuBB5OyBq3Fn1YFJd6sTAf8pd+I=;
        b=IxaOgUM37914xFt+/SlxINrABqOTjkO1y5zLi38TRvOqiTVqlCIBkkUN44J2efdn2j
         eGEFmSOswT6l+07khhv5ufJ/moZ0Ai78PZOZ/hwAZbR3i/vj72vYis0zS4ltOOTS2bHQ
         cEWNcGU6O4mrmrRMrj1V27TJ3wWnZVLjHK55vfNk3+H4StLtwRPiyDIXOwQMj8uLHaD5
         ctBeuc9kbasLvyctrWrK4YkAkdyNxA1sDJXqn2aiysp4voLfKlCWsup6fQyXtTOgZgwv
         SN7Ixi9QLnukIyFfJg7SgFy88Emqock+/hGAxNTl2+unPaeg+BouKy450Dsk6PS3j1lP
         ck7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770008947; x=1770613747;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pjbiA4RQMfYKLmkhjuBB5OyBq3Fn1YFJd6sTAf8pd+I=;
        b=YnDVXNLKi4pETn9fHlzDoQaunvjW8Qhp4A55BTzpmWnLUvlSbp8T+8tflXt99O0cJZ
         u5bhFFqINDOXkw2V8rUgEMF4jy/XORs4mm0HdKPkULHYUS54lA6p0MLdnAO29X/4yJHC
         VO7lhJW9HSAyEbIxbZTx3mQBbkdEY7pPzs7+0N98vrGUrzoVwAEIza8yiItONeoWGdY/
         xmlN64ZBEjFxrPF066zL6jfR5VVQkQUyOHDGEYN0MTONMdJ1RkBlL/BkrxvD/Kyi3o3I
         JMwrTQiu/THw2+PxS2P19ws01esODNtEdJZAg4ElO9mKcHQSmlHtxdMfXVOwTEQswGpq
         BtEw==
X-Forwarded-Encrypted: i=1; AJvYcCUI3SnNxXT39/Lr5ASfVBD9+Yql+9NTHRCz/GI17C8tx8GsJVeCJYnVl2bA+9CP7ejIZ2hY/44=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOJMWyVaogj++snOBcd9aBVVdxFpcLorKtad6nBpQlpDKsEgpX
	d8S2D3ck7sLCPy9pPzekXrkLh7JRWAdmfTDB53Ozktd/ggLN+LDtWECI
X-Gm-Gg: AZuq6aIg6FLYWrZ1L63fZLVlRRmmL1x2HVcrWkhmt7l9oyymWAT44GoFYr9pYO725dP
	1rs71q78Hu6Ej4Y42+LOCHJnuBVq13Llrzfaw/wvG0EGvajs7K5ySC9ihWMG9T/70BA+TgBzMm2
	oHFrvrbcDgz6EThn3lGrxZbzp+hD5kcl9Z5N9lrjh6dN9KwD7ZCyKIa4+ynfSfFLkEX+veF0G2w
	HZ0H9Zl+Lm+v8a5JBDhwd6/ubVkZw2hrQ2EjwhlwFRie5eD7L75DM7H97Z3SjeE5bJZtvbubbqZ
	Z7DBbCxJdYE5qkpOdQWYFUjVhXsJL8+fcqZhsj5iNH0ziu7euLPb4GZpDe87JcwrILNHTocnf0j
	jlYfktBzlNa4fzWtK9Mg0hjttIxV3b5Oiv8axvBGY+u250lm4O9sgOoHrk1oNmHsamFdiEKwYY4
	wngYTxwhw9DTHCjiOi0QGO4kRPnwBci8mxjbd+VzbspXhI+R4BZHGd8LA=
X-Received: by 2002:a05:6a21:1509:b0:38e:9acd:97b3 with SMTP id adf61e73a8af0-392e01a7a57mr9582307637.73.1770008946706;
        Sun, 01 Feb 2026 21:09:06 -0800 (PST)
Received: from google.com (61-230-34-48.dynamic-ip.hinet.net. [61.230.34.48])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b346de2sm128805315ad.0.2026.02.01.21.09.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Feb 2026 21:09:06 -0800 (PST)
Date: Mon, 2 Feb 2026 13:09:01 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: James Clark <james.clark@linaro.org>
Cc: suzuki.poulose@arm.com, mike.leach@linaro.org,
	alexander.shishkin@linux.intel.com, gregkh@linuxfoundation.org,
	mathieu.poirier@linaro.org, leo.yan@arm.com, Al.Grant@arm.com,
	jserv@ccns.ncku.edu.tw, marscheng@google.com, ericchancf@google.com,
	milesjiang@google.com, nickpan@google.com,
	coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3] coresight: etm3x: Fix cntr_val_show() to match
 cntr_val_store() behavior
Message-ID: <aYAxbbkHslAP9RBN@google.com>
References: <20251202082613.3265761-1-visitorckw@gmail.com>
 <3bec7ceb-61a8-4b38-a794-02ee2fc9e68c@linaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3bec7ceb-61a8-4b38-a794-02ee2fc9e68c@linaro.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-213024-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[visitorckw@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linaro.org:email]
X-Rspamd-Queue-Id: 9A150C8440
X-Rspamd-Action: no action

On Tue, Dec 02, 2025 at 09:26:19AM +0000, James Clark wrote:
> 
> 
> On 02/12/2025 8:26 am, Kuan-Wei Chiu wrote:
> > The cntr_val_show() function was intended to print the values of all
> > counters using a loop. However, due to a buffer overwrite issue with
> > sprintf(), it effectively only displayed the value of the last counter.
> > 
> > The companion function, cntr_val_store(), allows users to modify a
> > specific counter selected by 'cntr_idx'. To maintain consistency
> > between read and write operations and to align with the ETM4x driver
> > behavior, modify cntr_val_show() to report only the value of the
> > currently selected counter.
> > 
> > This change removes the loop and the "counter %d:" prefix, printing
> > only the hexadecimal value. It also adopts sysfs_emit() for standard
> > sysfs output formatting.
> > 
> > Fixes: a939fc5a71ad ("coresight-etm: add CoreSight ETM/PTM driver")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> > ---
> > Build test only.
> > 
> > Changes in v3:
> > - Switch format specifier to %#x to include the 0x prefix.
> > - Add Cc stable
> > 
> > v2: https://lore.kernel.org/lkml/20251201095228.1905489-1-visitorckw@gmail.com/
> > 
> >   .../hwtracing/coresight/coresight-etm3x-sysfs.c   | 15 ++++-----------
> >   1 file changed, 4 insertions(+), 11 deletions(-)
> > 
> > diff --git a/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
> > index 762109307b86..b3c67e96a82a 100644
> > --- a/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
> > +++ b/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
> > @@ -717,26 +717,19 @@ static DEVICE_ATTR_RW(cntr_rld_event);
> >   static ssize_t cntr_val_show(struct device *dev,
> >   			     struct device_attribute *attr, char *buf)
> >   {
> > -	int i, ret = 0;
> >   	u32 val;
> >   	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> >   	struct etm_config *config = &drvdata->config;
> >   	if (!coresight_get_mode(drvdata->csdev)) {
> >   		spin_lock(&drvdata->spinlock);
> > -		for (i = 0; i < drvdata->nr_cntr; i++)
> > -			ret += sprintf(buf, "counter %d: %x\n",
> > -				       i, config->cntr_val[i]);
> > +		val = config->cntr_val[config->cntr_idx];
> >   		spin_unlock(&drvdata->spinlock);
> > -		return ret;
> > -	}
> > -
> > -	for (i = 0; i < drvdata->nr_cntr; i++) {
> > -		val = etm_readl(drvdata, ETMCNTVRn(i));
> > -		ret += sprintf(buf, "counter %d: %x\n", i, val);
> > +	} else {
> > +		val = etm_readl(drvdata, ETMCNTVRn(config->cntr_idx));
> >   	}
> > -	return ret;
> > +	return sysfs_emit(buf, "%#x\n", val);
> >   }
> >   static ssize_t cntr_val_store(struct device *dev,
> 
> Reviewed-by: James Clark <james.clark@linaro.org>
> 
Thanks for the review!
Is there anything else I need to do for this fix to land?

Regards,
Kuan-Wei


