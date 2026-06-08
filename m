Return-Path: <stable+bounces-262076-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XgUbL0n1JmocowIAu9opvQ
	(envelope-from <stable+bounces-262076-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 08 Jun 2026 19:00:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5185D65907A
	for <lists+stable@lfdr.de>; Mon, 08 Jun 2026 19:00:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=ePk2UbuH;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262076-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-262076-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6D48C302BCE2
	for <lists+stable@lfdr.de>; Mon,  8 Jun 2026 16:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CAFD3D47CF;
	Mon,  8 Jun 2026 16:55:13 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D9B3D4129
	for <stable@vger.kernel.org>; Mon,  8 Jun 2026 16:55:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780937712; cv=none; b=ays0cZ4QaeZXDwBKrUec+ApdPIIBb3EaYBsxAkbwSJOAGox83rS5HC4QJ2Gx9jo2NwTagN0yEiZxpQsQQ6UP6Uz5SrnBxMfiEQbhBotDsRD5E6Cwz126mTnMzfzqAx7q2KolRPMfSPpfJ8gGZCAJJdBsc7oaF/MvrAnBZ3pdJoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780937712; c=relaxed/simple;
	bh=JrLLoG8h59aqXczDRkrWVQOmyYDESktsGOUmjEQO0Go=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mAWYpA2IhrvwY+r0Do+kOYYOmbum/Y9bOW/KDgxqNdpuj1ltGayfC2iLNh0L4t/x1s+BHZGR3louCiUprD6lBiTnQI3ZQcuHDrFiIgtwWNQn1iZe7gi2tK28V1otD6A+dpfnLKWrWgN1faEEuuWzSGTEJKt9j1LKvrlV6nlJfZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ePk2UbuH; arc=none smtp.client-ip=209.85.215.182
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c8588f8fef3so1717121a12.0
        for <stable@vger.kernel.org>; Mon, 08 Jun 2026 09:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780937710; x=1781542510; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=68P+IvGopl7vOMGvwR8RStoFVF/R6GJT532HBzXY5XY=;
        b=ePk2UbuHSgNQPK/JqG3zTUjxv6nSWGqLvPZM0QL3xlKmJ1I/PauYsEphPt4bejAk4i
         cA3riuhIti7Hvd1qQQbqOl+ksoQyBdBv09XjNne3P9e0BfVxZjlis9CHtA2e4x4dSHmC
         XTuOke5Sd8w5lHdX+OkS/dOqQvVzA16NMpzf+y9swLh0AIa9mCaLBP8r0z5y6MlCiUQh
         7qDF9ulPIVAJXDb8r1DNXHkHov+FXQpoL44Vbb7N7YvplBGhQLxZCtLNaJFSGGBSerGO
         hpJhd8j3Rt2B/5sD3bxH0IIIF1R+AQr1yPUBL4yFK8ZwKcu+a6NpbxNdXz7aq4QfsmCB
         Sc/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780937710; x=1781542510;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=68P+IvGopl7vOMGvwR8RStoFVF/R6GJT532HBzXY5XY=;
        b=cKxl9zI5bhhuVxLkHlmfAZhfbKOLwJnrd4rGOMFiIbbrVuMuotkMdM5q0tvzgR8d7/
         2E8NPF9EJEUSb/t49+b5lwSdvhTu1HKULa/EVE9dHXSc+oE4fvgqguIC8Qz4zSajbFDK
         jPk5dg1JKhHl4V/uHDjTQdJ8HBUMvNsyad5ebg+ZivgJCXll3fzBgET537ck0tUrtfh8
         BodDVNXseqkzVrf+5rBabPdrkGGM1/syC1k8048JRLKkjSym8yvYdmC1lHFQewlTydwZ
         9ED79g6f1dEYEIljSDk2SpUUQF/3z04ICjTVBfqonNJBaOGJ42ZOfjRMQS0VgJUZIb0c
         juVA==
X-Forwarded-Encrypted: i=1; AFNElJ82ftysW8t7EWyGBsgl/MbhAoz7KwHC0B9+ayy+MUScu52dOoLZNv2JcsYmuZJksHDLKN886z0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyh7vu8y5F0LGBMxTgHKNdo8FYkJC6/m9q8jIsHmZKn2Ed8m47i
	bpTXQNcVAwtlGUEsxPFxZ9C33FlEDvoa8ji2GybM6f0tAo8VXYeFJkJm
X-Gm-Gg: Acq92OGpzGqi1FgTOBQzJhrXFv6Xk456ccSXtDhlx8r7r3119BkVMyNOr7Ckw+qWCOy
	L70NX+AKbfdUV2Y3tTaVDtvHifMfRri6knCd1bfMX1PuB7vkdZTGeo8ah4sj5I2K5mw+L/ULM5f
	hSK4X8/Z0qsUBlTjKK5ldxleLpyoJnJqyKUTuJErv15uuyRNE59QNczGg24oV2uhPTgr7G/3/q7
	WAUlqkOjDIb2/dGoO7CDFiepJPgZwUiSFq4JZujAazM0MtN2Q760BmSghCte7fCFdCvt/8mmIhi
	WjWAHqep/NXRMV9uZdOLlaREUc/8bZjzAgch+r5LTYVIf+QiPrjcHbB3yOxSUYodsgPA9ifriBS
	XdkHKXZ1toximIw+WRul8gOzYgXTLjcstr5BtF82f58byQt/dQZ6G6hU17kY+Z9IQjrWyAO/fZw
	xmfleD5sHGYb8NtWGaCMRMpVqBsqmE8DTcqr6I
X-Received: by 2002:a05:6a21:685:b0:3a8:7fb:ca0e with SMTP id adf61e73a8af0-3b4ccf91e30mr20858772637.23.1780937710303;
        Mon, 08 Jun 2026 09:55:10 -0700 (PDT)
Received: from google.com ([2402:7500:498:d80a:6ed1:11c1:50ff:fc30])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85df034a2csm16345455a12.3.2026.06.08.09.55.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 09:55:09 -0700 (PDT)
Date: Tue, 9 Jun 2026 00:55:03 +0800
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
Message-ID: <aibz51FAJG1neRg1@google.com>
References: <20251202082613.3265761-1-visitorckw@gmail.com>
 <3bec7ceb-61a8-4b38-a794-02ee2fc9e68c@linaro.org>
 <aYAxbbkHslAP9RBN@google.com>
 <bb521240-ab53-4c5a-aa1d-6b140ed4262e@arm.com>
 <ac-BEX0Rfe9RBJJn@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac-BEX0Rfe9RBJJn@google.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262076-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:suzuki.poulose@arm.com,m:james.clark@linaro.org,m:mike.leach@linaro.org,m:alexander.shishkin@linux.intel.com,m:gregkh@linuxfoundation.org,m:mathieu.poirier@linaro.org,m:leo.yan@arm.com,m:Al.Grant@arm.com,m:jserv@ccns.ncku.edu.tw,m:marscheng@google.com,m:ericchancf@google.com,m:milesjiang@google.com,m:nickpan@google.com,m:coresight@lists.linaro.org,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER(0.00)[visitorckw@gmail.com,stable@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[visitorckw@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5185D65907A

Hi Suzuki,

On Fri, Apr 03, 2026 at 04:57:59PM +0800, Kuan-Wei Chiu wrote:
> Hi Suzuki,
> 
> On Mon, Feb 02, 2026 at 09:33:59AM +0000, Suzuki K Poulose wrote:
> > Hello
> > 
> > On 02/02/2026 05:09, Kuan-Wei Chiu wrote:
> > > On Tue, Dec 02, 2025 at 09:26:19AM +0000, James Clark wrote:
> > > > 
> > > > 
> > > > On 02/12/2025 8:26 am, Kuan-Wei Chiu wrote:
> > > > > The cntr_val_show() function was intended to print the values of all
> > > > > counters using a loop. However, due to a buffer overwrite issue with
> > > > > sprintf(), it effectively only displayed the value of the last counter.
> > > > > 
> > > > > The companion function, cntr_val_store(), allows users to modify a
> > > > > specific counter selected by 'cntr_idx'. To maintain consistency
> > > > > between read and write operations and to align with the ETM4x driver
> > > > > behavior, modify cntr_val_show() to report only the value of the
> > > > > currently selected counter.
> > > > > 
> > > > > This change removes the loop and the "counter %d:" prefix, printing
> > > > > only the hexadecimal value. It also adopts sysfs_emit() for standard
> > > > > sysfs output formatting.
> > > > > 
> > > > > Fixes: a939fc5a71ad ("coresight-etm: add CoreSight ETM/PTM driver")
> > > > > Cc: stable@vger.kernel.org
> > > > > Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> > > > > ---
> > > > > Build test only.
> > > > > 
> > > > > Changes in v3:
> > > > > - Switch format specifier to %#x to include the 0x prefix.
> > > > > - Add Cc stable
> > > > > 
> > > > > v2: https://lore.kernel.org/lkml/20251201095228.1905489-1-visitorckw@gmail.com/
> > > > > 
> > > > >    .../hwtracing/coresight/coresight-etm3x-sysfs.c   | 15 ++++-----------
> > > > >    1 file changed, 4 insertions(+), 11 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
> > > > > index 762109307b86..b3c67e96a82a 100644
> > > > > --- a/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
> > > > > +++ b/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
> > > > > @@ -717,26 +717,19 @@ static DEVICE_ATTR_RW(cntr_rld_event);
> > > > >    static ssize_t cntr_val_show(struct device *dev,
> > > > >    			     struct device_attribute *attr, char *buf)
> > > > >    {
> > > > > -	int i, ret = 0;
> > > > >    	u32 val;
> > > > >    	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> > > > >    	struct etm_config *config = &drvdata->config;
> > > > >    	if (!coresight_get_mode(drvdata->csdev)) {
> > > > >    		spin_lock(&drvdata->spinlock);
> > > > > -		for (i = 0; i < drvdata->nr_cntr; i++)
> > > > > -			ret += sprintf(buf, "counter %d: %x\n",
> > > > > -				       i, config->cntr_val[i]);
> > > > > +		val = config->cntr_val[config->cntr_idx];
> > > > >    		spin_unlock(&drvdata->spinlock);
> > > > > -		return ret;
> > > > > -	}
> > > > > -
> > > > > -	for (i = 0; i < drvdata->nr_cntr; i++) {
> > > > > -		val = etm_readl(drvdata, ETMCNTVRn(i));
> > > > > -		ret += sprintf(buf, "counter %d: %x\n", i, val);
> > > > > +	} else {
> > > > > +		val = etm_readl(drvdata, ETMCNTVRn(config->cntr_idx));
> > > > >    	}
> > > > > -	return ret;
> > > > > +	return sysfs_emit(buf, "%#x\n", val);
> > > > >    }
> > > > >    static ssize_t cntr_val_store(struct device *dev,
> > > > 
> > > > Reviewed-by: James Clark <james.clark@linaro.org>
> > > > 
> > > Thanks for the review!
> > > Is there anything else I need to do for this fix to land?
> > 
> > Thanks for the patch, I will queue this for the next release (v7.1).
> >
> Just a gentle ping.
> 
> Since the v7.1 merge window is presumably opening in about a week, I
> noticed this patch isn't in linux-next yet and wanted to send a quick
> reminder. Thanks.
> 
This patch still applies cleanly on top of linux-next.
I suspect this patch may have fallen through the cracks.
Would you still be willing to pick it up?

Regards,
Kuan-Wei

