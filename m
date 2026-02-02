Return-Path: <stable+bounces-213091-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eD8SE0bYgGnMBwMAu9opvQ
	(envelope-from <stable+bounces-213091-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 02 Feb 2026 18:00:54 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DF98CCF4B4
	for <lists+stable@lfdr.de>; Mon, 02 Feb 2026 18:00:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AD4493028341
	for <lists+stable@lfdr.de>; Mon,  2 Feb 2026 16:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 469CB3803F1;
	Mon,  2 Feb 2026 16:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kxYwA+8L"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f195.google.com (mail-dy1-f195.google.com [74.125.82.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC9F337F748
	for <stable@vger.kernel.org>; Mon,  2 Feb 2026 16:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770051518; cv=none; b=AwL2JaE5J2+0VHF9bDgSclvsyc4YEYH1LExunQlXupUcuM07QN6T3O/2+vj5RiqH4xQj1WKeV510ZkRAjoUg/BJ4ilKVL1Bef3PZedaE/VYLDxAeI8m/OJGYlR2CeoygbWHMiXYxR72QcU3/YETZdoW3XMN79NV/oJCJ6gkOInw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770051518; c=relaxed/simple;
	bh=GlaPGEDFHyTZ2dS4emy5gCI3JVppCamAltc18GwikYg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ehIoQ5M3y2WbSKzPpeqN8A0MR8WLaOFDdLNQ06JuMoeB2tJ0PZnrpTWOKBwoGFZvoOnF8LRqZOmKqsmRDSKoKiNZOC2BO7aTY6JwkXEwmB+g/fDhKFyCajRwyyhQYQWCR6iJ4A7hw36/SR1ohkbZLz6vNw5npBdwLueE37jwcwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kxYwA+8L; arc=none smtp.client-ip=74.125.82.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f195.google.com with SMTP id 5a478bee46e88-2b740872a01so234090eec.1
        for <stable@vger.kernel.org>; Mon, 02 Feb 2026 08:58:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770051516; x=1770656316; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VmmqstkUFuOvTFjtVoWL5THYOk8yMG664rkSQV/BOG8=;
        b=kxYwA+8LFTgxJMBozyJpuwj0TDLH/QTemTJcIH0SdZupfTO3LasXC6z7+XmO8vYtXy
         UfofB4qWQ2GqjA7V9y0+DC/E+hPhzbSaDlo5cwgt+eCFJ/BrM2MK7PmI1TsIAZSwAJaK
         4US/U1phWc4iN+aoCZg8LplLI08xaCw80yNQhI8qS1zEa3dZzSNDCOsAqsv01KCdvTiw
         4vsLRokCKAClXGP9o1xAnMuJQdG+/FZ/Jzkf5/AJqiph1yqsoFnZJ5uya2nJgMpFnz/w
         iKlNoHi9NDlO29PM/8d+xp8jwlepzaTZBqtGDmUm4/nX/LJqeHQAE81q6vOwbEOWN1fB
         cfPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770051516; x=1770656316;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VmmqstkUFuOvTFjtVoWL5THYOk8yMG664rkSQV/BOG8=;
        b=rrw/52oWuhNAo9L9lvawn4zZSGBszsaykduOQWedUURDHxo6pzsVNEZXH+xeV0QGe2
         yGI4pWgrBKRdw8E0eqLmRI5Sit5bEI708aimwWC7Q5hPUk2lPVXtbgXMRNSRhU1KYcUf
         6Jc6PfYo0EO6hKBadIywqkvJeTSh2ZEy/WBZF33BthK4MsPSFIIHPY1xo488QBYG5etT
         feFRUlQdmowbSh8Uixzy89NVBB6TfqLWL2GDuSfCxKE2bUf/qZOECgSF31Sfty+85Hi7
         6gbooK0A4HatSqdKbs8I97tawHk2ZP8qBKvkL17+AxVaYcORF3WvOrnn0P2zay5M2yb1
         Tvyg==
X-Forwarded-Encrypted: i=1; AJvYcCU8lYHkhVYLYM3o48byLcl/h155jqcVVPKOz92sBjdDRe0HsniA7qNH5zzHDUVgFr8zUv4hRSY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuuP8dBRBzVJtU/5fHEzSUz/zOY86HGEzA3xyJmlympLWXfGTp
	9YYpD92LWjV34W2H7hJ6X77DmDp7W8NZr+41R+VKYStrVVhTerOfAB88
X-Gm-Gg: AZuq6aI/XOl7mKZCNybkS0vmLohv2wBzvgWibN+3vH1RAWx7u4YcFN5bl75UTxK+F9T
	H3883pjZbIK0+EWaLoNWsdTTMGugiYvID8p0XcE1SbHMqjTTPx2EJYMQJ/2Oa56a2/UTgzxCNwj
	Wfe2bEVIA64DN1vAXN9Cg1ocbN+cE97hw1YN2jjMRW2kpSThrN4P/ASbF3Sus3h1Pciggx54yag
	bNZwXtIPlTYyYBhgLniPBkzDHbXKiCE8SzdeafwJ2zTuM1RuuAomHLa6Kan7eF6qIhu+6kqxibC
	l1b3zUMpOZSNm9J0yUqbnyQKZyMg8X2GJRsZGqO1VX4G+mzK7qc50mloYbAWkjyFfbCg6/utnHL
	SfIpiycjVgExX+069bhadQdLxwWN43pgBDO/qWdPMHJD/NAAEjowlGqSMiOwLRQPGbUA72OR0Zf
	rVtr0oowCBBY7M60MvyigOeOFs
X-Received: by 2002:a05:693c:408d:b0:2b7:ee0e:e9ba with SMTP id 5a478bee46e88-2b7ee0ef555mr2160005eec.10.1770051515371;
        Mon, 02 Feb 2026 08:58:35 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b7a1abedcasm20353466eec.21.2026.02.02.08.58.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 08:58:34 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 2 Feb 2026 08:58:33 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Gabor Juhos <j4g8y7@gmail.com>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] hwmon: gpio-fan: allow to stop FANs when CONFIG_PM is
 disabled
Message-ID: <12798a6f-ab17-40aa-9b0c-eb44a2684ce3@roeck-us.net>
References: <20260202-gpio-fan-stop-fix-v1-1-c7853183d93d@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260202-gpio-fan-stop-fix-v1-1-c7853183d93d@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-213091-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	DMARC_NA(0.00)[roeck-us.net];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux@roeck-us.net,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DF98CCF4B4
X-Rspamd-Action: no action

On Mon, Feb 02, 2026 at 04:58:57PM +0100, Gabor Juhos wrote:
> When CONFIG_PM is disabled, the GPIO controlled FANs can't be stopped by
> using the sysfs attributes since commit 0d01110e6356 ("hwmon: (gpio-fan)
> Add regulator support").
> 
> Using either the 'pwm1' or the 'fan1_target' attribute fails the same way:
> 
>   $ echo 0 > /sys/class/hwmon/hwmon1/pwm1
>   ash: write error: Function not implemented
>   $ echo 0 > /sys/class/hwmon/hwmon1/fan1_target
>   ash: write error: Function not implemented
> 
> Both commands were working flawlessly before the mentioned commit.
> 
> The issue happens because pm_runtime_put_sync() returns with -ENOSYS
> when CONFIG_PM is disabled, and the set_fan_speed() function handles
> this as an error.
> 
> In order to restore the previous behaviour, change the error check in
> the set_fan_speed() function to ignore the -ENOSYS error code.
> 
> Cc: stable@vger.kernel.org
> Fixes: 0d01110e6356 ("hwmon: (gpio-fan) Add regulator support")
> Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>

Applied.

Thanks,
Guenter

