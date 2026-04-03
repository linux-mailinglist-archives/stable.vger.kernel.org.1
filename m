Return-Path: <stable+bounces-233158-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ILMZOx6Bz2mvwgYAu9opvQ
	(envelope-from <stable+bounces-233158-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 03 Apr 2026 10:58:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 67659392685
	for <lists+stable@lfdr.de>; Fri, 03 Apr 2026 10:58:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 61DD03016BA7
	for <lists+stable@lfdr.de>; Fri,  3 Apr 2026 08:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CCEA35E952;
	Fri,  3 Apr 2026 08:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QT+EmKYU"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DFCE1F92E
	for <stable@vger.kernel.org>; Fri,  3 Apr 2026 08:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775206681; cv=none; b=p41LsJmIJoIyEhrkzfOi60IV63qsf4fr2oF2gL8l5VUtGRKa7/UUGAhEAmGYsiFiClJwxSbWae8pHLD2S/S/Q9ZfnFwZxZmIHFKGknbQwy1uaphYPiojEyh9ezi7xb2gY7xt7OO6nEUy+7481nkRwhOS0y390kpec8lqM0c7j4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775206681; c=relaxed/simple;
	bh=UUsZF2RTkbHP8qOi4OtnUD3lJ240sZg2HgpZ93PPb7I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oDuNKMNxrwg2GStL00E0lvHyi6HCVVZOk0Ij3YFDYdn8SSGx14ceNIMj2hvd6282N8pyI/DjG0BzfpjMPzjGq09Iv0PZfZhNBY5jKhfr+hXVhACXg4vRGYI8YcvOlwKhadniM9RdFDp4obELDG1rtgLHZfz+t8FWYA69h6v0SfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QT+EmKYU; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-82cd70febc7so1343230b3a.2
        for <stable@vger.kernel.org>; Fri, 03 Apr 2026 01:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775206679; x=1775811479; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KxQFvqelXHDHyvDQl7EWq8XKSqTOS9+kkTkwsuSR9EM=;
        b=QT+EmKYU85hI1FkThIlaZrXAsLvepg+Xa2vwqsojqpQvu0EtigTfgafDWPKHkaK9/A
         fmZHvcwiP237A6HiQP0zTG/BCRubBO6yd8Z2tNE2j5fMyx7E+BIRkwrs2M+joksKfW9a
         OkZSz3YtNmSKaul9oQg/DP/eiwA+pW4WDWkNud2lyGXNWxHKy/AJEaMdZ4EiNfui0IGE
         v8FE11QVTCUMCJkqSpV6NrT5F2jy8iJKS+bg1UoJGOn9eI0OvD5Ag8y3+68xAhVrlI5X
         dwY2tIxhsw+mTFBkXKW5ZAeVp3ZZlaIRj8C80FHreSfJUxjiVtGNifs2c1fXTkMoNqlP
         3vYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775206679; x=1775811479;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KxQFvqelXHDHyvDQl7EWq8XKSqTOS9+kkTkwsuSR9EM=;
        b=bJISRyu9Oi7Fc0/pINUc1J5gpoWQ9cE+ezEkeli9Z2DRIdzem+q8qYIG9SmWxcj96F
         Bh6aBnZafxnSiSsLbxZ+NLvvLNRqMzHLkmGxjBSYZTaOnvYuoZeTJjZVmU4QSvGOK3ZP
         uHBtPQtp40R8j4cCUkCjR6A6E5h5Nhg5eTxVOUPaVxoVKVa5OSiQGGjrqALGVEcVdTqY
         KDwbc5A0O0tAd5AKb+rIISO+dOuJI1YQgPnIQhTNyEYSP7FCPh5CiUYnylhpezbq+L1Q
         XpUQ8b9O4xdzmxiT7e8IVC7K6PKgbMvOM7EuYfaHCGgAYK30suBeByzqwbRuYOxgW7uJ
         0bdQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2E+BNxu3dvdqa1XRzs2CM+YG1kW3Id1g9StSS3+4UPYScSaiRrPfi0BeH0SIpSwm37aVBSXY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+XypjT9AtbFVGHOG7zNqeZ4WqDH0qH+3+FXqum4Vfa70EeyUi
	n5b7ac19Rv3FgZtVQG9n4MfwXxcvPYci7cSY6q87/3ZWKGVYWus9RqL8
X-Gm-Gg: AeBDiev7eCBgi2euDJUy652ehGfblTATS/BQM/pB4dxgBCGBrLbf2bmZcXknhk4qFG7
	dM6ZB1FmRIHcuC/2BSutXHwWAhqbp86SVugu7YVoWuyHhbGmNS2DkUtE9ORFrkEQOik7ses4XYD
	l2gOQw95wU0RXd/FNWK0Mx7+qGXVOpzzKhuAk34+DpbvE/0HTXVbsGO+tBREaHRgssPRp7buSaw
	utmAjIxHlp7qI+juvCcKWDjB3W11GsQXfCcpYrK2jxIzrSgEMuzmdnSVw0kuSoJiRe8C+tGpCb/
	cd/GNEouOCpMI0WYGeElYxbcClbOSdl+wPENxXNo2VDElUgiYZ26cxJqOnby9KgHzizVLTCH84X
	eVV7BrEbiReonZUucdeJ/lRH3NyiPHG34wMw9PDbP1oW2ggp3tK8gBYUAOaYwDEc8t6bMfQd6Zr
	ydzlBGIv8wNiKsA5fMmKAqrLQSCDX2tLyZP+O9t9ejv9bHYnw=
X-Received: by 2002:a05:6a00:3027:b0:824:93e4:2ddf with SMTP id d2e1a72fcca58-82d0da3f8afmr2250267b3a.13.1775206679416;
        Fri, 03 Apr 2026 01:57:59 -0700 (PDT)
Received: from google.com ([2402:7500:477:c367:541d:a40c:7624:4482])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9c68273sm7096151b3a.41.2026.04.03.01.57.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 01:57:58 -0700 (PDT)
Date: Fri, 3 Apr 2026 16:57:53 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: James Clark <james.clark@linaro.org>, mike.leach@linaro.org,
	alexander.shishkin@linux.intel.com, gregkh@linuxfoundation.org,
	mathieu.poirier@linaro.org, leo.yan@arm.com, Al.Grant@arm.com,
	jserv@ccns.ncku.edu.tw, marscheng@google.com, ericchancf@google.com,
	milesjiang@google.com, nickpan@google.com,
	coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3] coresight: etm3x: Fix cntr_val_show() to match
 cntr_val_store() behavior
Message-ID: <ac-BEX0Rfe9RBJJn@google.com>
References: <20251202082613.3265761-1-visitorckw@gmail.com>
 <3bec7ceb-61a8-4b38-a794-02ee2fc9e68c@linaro.org>
 <aYAxbbkHslAP9RBN@google.com>
 <bb521240-ab53-4c5a-aa1d-6b140ed4262e@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb521240-ab53-4c5a-aa1d-6b140ed4262e@arm.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-233158-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[visitorckw@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 67659392685
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Suzuki,

On Mon, Feb 02, 2026 at 09:33:59AM +0000, Suzuki K Poulose wrote:
> Hello
> 
> On 02/02/2026 05:09, Kuan-Wei Chiu wrote:
> > On Tue, Dec 02, 2025 at 09:26:19AM +0000, James Clark wrote:
> > > 
> > > 
> > > On 02/12/2025 8:26 am, Kuan-Wei Chiu wrote:
> > > > The cntr_val_show() function was intended to print the values of all
> > > > counters using a loop. However, due to a buffer overwrite issue with
> > > > sprintf(), it effectively only displayed the value of the last counter.
> > > > 
> > > > The companion function, cntr_val_store(), allows users to modify a
> > > > specific counter selected by 'cntr_idx'. To maintain consistency
> > > > between read and write operations and to align with the ETM4x driver
> > > > behavior, modify cntr_val_show() to report only the value of the
> > > > currently selected counter.
> > > > 
> > > > This change removes the loop and the "counter %d:" prefix, printing
> > > > only the hexadecimal value. It also adopts sysfs_emit() for standard
> > > > sysfs output formatting.
> > > > 
> > > > Fixes: a939fc5a71ad ("coresight-etm: add CoreSight ETM/PTM driver")
> > > > Cc: stable@vger.kernel.org
> > > > Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> > > > ---
> > > > Build test only.
> > > > 
> > > > Changes in v3:
> > > > - Switch format specifier to %#x to include the 0x prefix.
> > > > - Add Cc stable
> > > > 
> > > > v2: https://lore.kernel.org/lkml/20251201095228.1905489-1-visitorckw@gmail.com/
> > > > 
> > > >    .../hwtracing/coresight/coresight-etm3x-sysfs.c   | 15 ++++-----------
> > > >    1 file changed, 4 insertions(+), 11 deletions(-)
> > > > 
> > > > diff --git a/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
> > > > index 762109307b86..b3c67e96a82a 100644
> > > > --- a/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
> > > > +++ b/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
> > > > @@ -717,26 +717,19 @@ static DEVICE_ATTR_RW(cntr_rld_event);
> > > >    static ssize_t cntr_val_show(struct device *dev,
> > > >    			     struct device_attribute *attr, char *buf)
> > > >    {
> > > > -	int i, ret = 0;
> > > >    	u32 val;
> > > >    	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> > > >    	struct etm_config *config = &drvdata->config;
> > > >    	if (!coresight_get_mode(drvdata->csdev)) {
> > > >    		spin_lock(&drvdata->spinlock);
> > > > -		for (i = 0; i < drvdata->nr_cntr; i++)
> > > > -			ret += sprintf(buf, "counter %d: %x\n",
> > > > -				       i, config->cntr_val[i]);
> > > > +		val = config->cntr_val[config->cntr_idx];
> > > >    		spin_unlock(&drvdata->spinlock);
> > > > -		return ret;
> > > > -	}
> > > > -
> > > > -	for (i = 0; i < drvdata->nr_cntr; i++) {
> > > > -		val = etm_readl(drvdata, ETMCNTVRn(i));
> > > > -		ret += sprintf(buf, "counter %d: %x\n", i, val);
> > > > +	} else {
> > > > +		val = etm_readl(drvdata, ETMCNTVRn(config->cntr_idx));
> > > >    	}
> > > > -	return ret;
> > > > +	return sysfs_emit(buf, "%#x\n", val);
> > > >    }
> > > >    static ssize_t cntr_val_store(struct device *dev,
> > > 
> > > Reviewed-by: James Clark <james.clark@linaro.org>
> > > 
> > Thanks for the review!
> > Is there anything else I need to do for this fix to land?
> 
> Thanks for the patch, I will queue this for the next release (v7.1).
>
Just a gentle ping.

Since the v7.1 merge window is presumably opening in about a week, I
noticed this patch isn't in linux-next yet and wanted to send a quick
reminder. Thanks.

Regards,
Kuan-Wei

