Return-Path: <stable+bounces-272713-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +nERKd+PTmrfPQIAu9opvQ
	(envelope-from <stable+bounces-272713-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Jul 2026 19:58:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 95C037295C4
	for <lists+stable@lfdr.de>; Wed, 08 Jul 2026 19:58:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=X2cx492P;
	dmarc=pass (policy=none) header.from=intel.com;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272713-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-272713-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BD1433013C77
	for <lists+stable@lfdr.de>; Wed,  8 Jul 2026 17:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C8294C041A;
	Wed,  8 Jul 2026 17:58:34 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF3747F2E1;
	Wed,  8 Jul 2026 17:58:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783533513; cv=none; b=Kxv2aiWVx0UFDDf5s67BukCQvX+hcIERIHOA/fbgtFRptT2CZE4Jxvst3Yecwkoeg31MS0RBjh/j3r6lE1fnudP04ZROHZiUlFM1+fpBBqa/OdvSq/rhMRYlcnNp9DtpnZv9jjN50nUtlyb7TPM/77l1njkdpvwUgcK0bZOw+Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783533513; c=relaxed/simple;
	bh=vHCvyggaVGP/UrSeuuouhmlV8J6mtVFiyBdN7FWC2DM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QqxTjVyJPjKr26qdprYqyXG4D2eNDIuYLjB6BVXnQLcqxdlWJvFTNHq/ViKL7mxxi50GpHCqDIF3tKJiDTa03ZYSxy2GeldsxMtZvQxiPsn93OaZsH9B5mpZ6vf8IZP298g4uNhAKUapt/033lO1elUV1L3iJaVXzThbWuTZeRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X2cx492P; arc=none smtp.client-ip=192.198.163.15
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783533513; x=1815069513;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=vHCvyggaVGP/UrSeuuouhmlV8J6mtVFiyBdN7FWC2DM=;
  b=X2cx492PFMwfUdbZEgmVtisK5Rhr4bCsETicoU99z363RVwBavgDSI2t
   HBzC2x8U/9ET9oSyVrPh2B0PC4cv3qFOH+k3A8qshlHSD9KCFa+uY9Grg
   SJywGZt6MnMv7nBgtARwqnX+Sylm/H6fbtDBFoFytFqimLXCxssT5fYgk
   gZT319xcGpfVFSv2U20jXtDjYSorGM0hWOjcBFtJUuMj0ml2R77OWj9nR
   2+nfH3LkuQpUj7haa/+Pke72nAdlw0mF1BDioERag3mgfZHZr+vVqLfqX
   3MaXIj/pZhkILVaWN6QyesfzbzrUT6W10tspF+3/UWYNw67INAOjmeaK7
   g==;
X-CSE-ConnectionGUID: 87QMfulwR7ez8bKqbxB2Wg==
X-CSE-MsgGUID: vWlDeE8lTgOrFlCzJBuXKg==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="84322819"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="84322819"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2026 10:58:32 -0700
X-CSE-ConnectionGUID: pkLC4B36SJC05LijJsRhWQ==
X-CSE-MsgGUID: GSasUqeuQ9axFcZZiXeitg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="258223479"
Received: from gabaabhi-mobl2.amr.corp.intel.com (HELO [10.125.111.97]) ([10.125.111.97])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2026 10:58:31 -0700
Message-ID: <ec235cb20601651d7073949fdb913c96fb742ead.camel@linux.intel.com>
Subject: Re: [PATCH v3 2/2] HID: sensor: custom: Fix field sysfs group
 cleanup on failure
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: Haoxiang Li <haoxiang_li2024@163.com>, jikos@kernel.org,
 jic23@kernel.org, 	bentiss@kernel.org
Cc: linux-input@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Wed, 08 Jul 2026 10:58:30 -0700
In-Reply-To: <20260707071545.3087073-3-haoxiang_li2024@163.com>
References: <20260707071545.3087073-1-haoxiang_li2024@163.com>
	 <20260707071545.3087073-3-haoxiang_li2024@163.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-272713-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:haoxiang_li2024@163.com,m:jikos@kernel.org,m:jic23@kernel.org,m:bentiss@kernel.org,m:linux-input@vger.kernel.org,m:linux-iio@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[srinivas.pandruvada@linux.intel.com,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[163.com,kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[srinivas.pandruvada@linux.intel.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,intel.com:email,intel.com:dkim,linux.intel.com:mid,linux.intel.com:from_mime,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 95C037295C4

On Tue, 2026-07-07 at 15:15 +0800, Haoxiang Li wrote:
> hid_sensor_custom_add_attributes() creates one sysfs group for each
> custom sensor field. If sysfs_create_group() fails after some groups
> have already been created, the function returns the error without
> removing the previously created groups.
>=20
> Add a local unwind path to remove the groups that were already
> created.
> With enable_sensor exposed only after the field attributes are ready,
> this path can free sensor_inst->fields without leaving enable_sensor
> able to access pointers into that array.
>=20
> Fixes: 4a7de0519df5 ("HID: sensor: Custom and Generic sensor
> support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>

Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

> ---
> =C2=A0drivers/hid/hid-sensor-custom.c | 9 ++++++++-
> =C2=A01 file changed, 8 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/hid/hid-sensor-custom.c b/drivers/hid/hid-
> sensor-custom.c
> index 6b0da2e0e1c9..c2b425afd951 100644
> --- a/drivers/hid/hid-sensor-custom.c
> +++ b/drivers/hid/hid-sensor-custom.c
> @@ -609,7 +609,7 @@ static int
> hid_sensor_custom_add_attributes(struct hid_sensor_custom
> =C2=A0					 &sensor_inst->fields[i].
> =C2=A0				=09
> hid_custom_attribute_group);
> =C2=A0		if (ret)
> -			break;
> +			goto err_remove_groups;
> =C2=A0
> =C2=A0		/* For power or report field store indexes */
> =C2=A0		if (sensor_inst->fields[i].attribute.attrib_id =3D=3D
> @@ -621,6 +621,13 @@ static int
> hid_sensor_custom_add_attributes(struct hid_sensor_custom
> =C2=A0	}
> =C2=A0
> =C2=A0	return ret;
> +
> +err_remove_groups:
> +	while (--i >=3D 0)
> +		sysfs_remove_group(&sensor_inst->pdev->dev.kobj,
> +				=C2=A0=C2=A0 &sensor_inst-
> >fields[i].hid_custom_attribute_group);
> +	kfree(sensor_inst->fields);
> +	return ret;
> =C2=A0}
> =C2=A0
> =C2=A0static void hid_sensor_custom_remove_attributes(struct
> hid_sensor_custom *

