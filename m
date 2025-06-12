Return-Path: <stable+bounces-152543-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD6FEAD6B22
	for <lists+stable@lfdr.de>; Thu, 12 Jun 2025 10:43:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B270917ABC0
	for <lists+stable@lfdr.de>; Thu, 12 Jun 2025 08:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78EFA228CB5;
	Thu, 12 Jun 2025 08:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f6HpwNVF"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67DF322068B
	for <stable@vger.kernel.org>; Thu, 12 Jun 2025 08:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749717574; cv=none; b=Zxdf3oJtZwCICxdsehsUzh+LF8AGr77lBxtQIodcKoa2kCs7RiuBuwXY2WkCZEjPysODcb74vefFwUeh+InXnYasY076OTO4Vo3Vgl562F13oGxFPLT739KwO7eYLI/kwbe2lKsTbzyFxoqIqZcvOHy4ZSML3ycw63h/s2VpmvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749717574; c=relaxed/simple;
	bh=hJ7X/tNOTl73bwX25xhIlJdNu9sTqCaD1Ms/vj4d5r8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S/VrioYwXxAGycrjukgKIdhsJ1nwL2o4X+DTUPvlvVKjGF5MQjqRtRCZ63PhKr5c/Iz9N3O/5aQPGP3Oa7t/VHzVePzFFuEMWNgTQaccvYMjiGsljWsv9o6DhaZLCsGEwN9+pP4fWiRBU471eCQr4t0nun4sD9HmhhoqGJrZ2qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=f6HpwNVF; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3a510432236so665312f8f.0
        for <stable@vger.kernel.org>; Thu, 12 Jun 2025 01:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749717570; x=1750322370; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xMn86gBGFQBElUD4C04aCEWWj1Sy8fLs55GPp5ijFjA=;
        b=f6HpwNVFfRi6W2Sms6MVNsmZYI8KveHZfl5sXNiONtB3sWnyVSGfRsYBZTYaCAhKHS
         ow9wJHssthE1f/VBDrhhCvzvLJpgdxwdcPQ4hsd+rOMAkPPTpKzX4X+tzcK636E2lwDc
         jd8hF1Zx0dpZcHRNNRvRrl7dXNWfyVu4tdI47FliadoQX2UoRhBGLT0pRe54aOZZp4Nr
         /qmJO86dAlFVhMP2YP5q9V5VOefgEry+/t6ZSO2lUrGzJ832ddopLSwIfnNU2RLBc0ED
         8TROy/N9a8W7zpmJWHf/SfccoGJs1Z96uOA/OK+lDTI41JBkfAH/nQa/xNrFrpz8KKz/
         lNWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749717570; x=1750322370;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xMn86gBGFQBElUD4C04aCEWWj1Sy8fLs55GPp5ijFjA=;
        b=Jf+gMxbNA1QjHl9LS84OF1Qcd0NrBXEPpKmfewPFEYaaut05GXdfaJ+3spiVWCq9p3
         z0NelfZEKqy4SY3wBaV0ebmc5m7hvX4KC1rRYHpUoxepdCQDDqD6ZM/6KL1kJ83Mh85p
         1rLlLRMkidzc6cTPCROwv5vzd1OMQxfGU3LHUbO/6+a89B68CYiY/x1O3iLKTzHGLAU4
         pOuoWhTjuNe0oCYITLfp8bseh4a2xi7nnIJG2hyGuUuKHrKD/Fr7Lvh0IMagrCQxLTvn
         jQjrYeneS0PY5uyreZ9/JSRnHdoEV7+hqI0SzIA05+Vw9REPuE3ff2IgzndgZfCQmGzV
         7Vwg==
X-Forwarded-Encrypted: i=1; AJvYcCWQRyJMO2Aisupu2mxmI5OSh+bQchO++FHf3oFLL2GpgEwHhK2pqNCq14U9B5A7HKP8+xE0ovw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxobFvDb9VOYqKNr+mZz3Yk1Wr1w604EsXh5v9l9T/RpfVCQIuv
	7+6rrsKvuKdz5xD+iivaZqLzBNfj3Xy6NxuKNEGDr2EfyeB6VZyMZ7v01SZbZAIQo14=
X-Gm-Gg: ASbGncux572xLTOiqhuanYxNUvAh63BH2YIF4T4V1L1qeWQnqDOMA9Ih41oqahz5seZ
	1LBfus0TnJdTK5KnC8HcKi8ga8kPqaNjV6mgqfc5foLHP/929hf8skU+NyyhVqP3J2ul5j2GHVO
	BlqB8wil7KErQXYZrmTOyuJrP+VXs9LMOET11qdB0E/SAnLXhuz9YUX8qXg469hB76A7ilAClS9
	jP/0m3w0efDmXhEVwJ5Hn3Dmy57pELz4/h1NvHpuDAqMnXujY+41jpKNekm5XZTzyi/vIPU3Oqu
	eZEKX8r+EU0KVE/1lKH1/ZI7dVQ7h2idDFoqHSXi8K0zENJchdr63Mu63/Y4HBixhJs=
X-Google-Smtp-Source: AGHT+IF/U38N89Oos/Ii+uKueDvpQelJtkG4+ZSkUxRWatEFCL62scczRT/E2Bk0UmIqZpbCKrbN4g==
X-Received: by 2002:a05:6000:178a:b0:3a4:f038:af76 with SMTP id ffacd0b85a97d-3a56130bf3emr1772951f8f.53.1749717570107;
        Thu, 12 Jun 2025 01:39:30 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3a561b4bb17sm1299122f8f.68.2025.06.12.01.39.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 01:39:29 -0700 (PDT)
Date: Thu, 12 Jun 2025 11:39:25 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Karan Tilak Kumar <kartilak@cisco.com>
Cc: sebaddel@cisco.com, arulponn@cisco.com, djhawar@cisco.com,
	gcboffa@cisco.com, mkai2@cisco.com, satishkh@cisco.com,
	aeasi@cisco.com, jejb@linux.ibm.com, martin.petersen@oracle.com,
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
	jmeneghi@redhat.com, revers@redhat.com, stable@vger.kernel.org
Subject: Re: [PATCH v3 2/5] scsi: fnic: Fix crash in fnic_wq_cmpl_handler
 when FDMI times out
Message-ID: <aEqSPahh0b5h39J0@stanley.mountain>
References: <20250612004426.4661-1-kartilak@cisco.com>
 <20250612004426.4661-2-kartilak@cisco.com>
 <aEqE5okf2jfV9kwt@stanley.mountain>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aEqE5okf2jfV9kwt@stanley.mountain>

On Thu, Jun 12, 2025 at 10:42:30AM +0300, Dan Carpenter wrote:
> On Wed, Jun 11, 2025 at 05:44:23PM -0700, Karan Tilak Kumar wrote:
> > When both the RHBA and RPA FDMI requests time out, fnic reuses a frame
> > to send ABTS for each of them. On send completion, this causes an
> > attempt to free the same frame twice that leads to a crash.
> > 
> > Fix crash by allocating separate frames for RHBA and RPA,
> > and modify ABTS logic accordingly.
> > 
> > Tested by checking MDS for FDMI information.
> > Tested by using instrumented driver to:
> > Drop PLOGI response
> > Drop RHBA response
> > Drop RPA response
> > Drop RHBA and RPA response
> > Drop PLOGI response + ABTS response
> > Drop RHBA response + ABTS response
> > Drop RPA response + ABTS response
> > Drop RHBA and RPA response + ABTS response for both of them
> > 
> > Fixes: 09c1e6ab4ab2 ("scsi: fnic: Add and integrate support for FDMI")
> > Reviewed-by: Sesidhar Baddela <sebaddel@cisco.com>
> > Reviewed-by: Arulprabhu Ponnusamy <arulponn@cisco.com>
> > Reviewed-by: Gian Carlo Boffa <gcboffa@cisco.com>
> > Tested-by: Arun Easi <aeasi@cisco.com>
> > Co-developed-by: Arun Easi <aeasi@cisco.com>
> > Signed-off-by: Arun Easi <aeasi@cisco.com>
> > Tested-by: Karan Tilak Kumar <kartilak@cisco.com>
> > Cc: <stable@vger.kernel.org> # 6.14.x Please see patch description
> 
> I'm a bit confused.  Why do we need to specify 6.14.x?  I would have
> assumed that the Fixes tag was enough information.  What are we supposed
> to see in the patch description?
> 
> I suspect you're making this too complicated...  Just put
> Cc: <stable@vger.kernel.org> and a Fixes tag and let the scripts figure
> it out.  Or put in the commit description, "The Fixes tag points to
> an older kernel because XXX but really this should only be backported
> to 6.14.x because YYY."

But here even with the comment in the commit description, you would still
just say:

Cc: <stable@vger.kernel.org> # 6.14.x

The stable maintainers trust you to list the correct kernel and don't
need to know the reasoning.

I much prefer to keep it simple whenever possible.  We had bad CVE where
someone left off the Fixes tag and instead specified
"Cc: <stable@vger.kernel.org> # 4.1" where 4.1 was the oldest supported
kernel on kernel.org.  The patch should have been applied to the older
vendor kernels but it wasn't because the the tag was wrong.

regards,
dan carpenter


