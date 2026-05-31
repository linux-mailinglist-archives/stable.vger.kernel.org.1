Return-Path: <stable+bounces-259357-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kIbeIz5RHGqaMQkAu9opvQ
	(envelope-from <stable+bounces-259357-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 31 May 2026 17:18:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AA9E616C9B
	for <lists+stable@lfdr.de>; Sun, 31 May 2026 17:18:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 22DA43017BEE
	for <lists+stable@lfdr.de>; Sun, 31 May 2026 15:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E861390998;
	Sun, 31 May 2026 15:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pelago.org.uk header.i=@pelago.org.uk header.b="XDNrlPVK"
X-Original-To: stable@vger.kernel.org
Received: from mx1.mythic-beasts.com (mx1.mythic-beasts.com [46.235.224.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3328E30E0E9;
	Sun, 31 May 2026 15:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.224.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780240695; cv=none; b=cuQw3hfIw/PK0yb4WyaBH8nPfzuuZ4201bet1ydbXnCesZdyj4sqs6qcgUCDJd+OclnvZHapD0occOgjTa5LtSMlxXVUGhWzZb7F0oGriiZVtJJXxC6Na/V36B3b0H/yPqfMNi3uaVcp8HJFxfjrml1jyjBS9anfY/LmIw14JRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780240695; c=relaxed/simple;
	bh=rhOTB4kvjmISDBctDwT5HOz93gVp+fe2NG4uXfye8nc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qjyaiJ2u0hBD5Va+FbPYEarBYOn3HCbY13For1l4kpCupa1jl5i79IZs133gf8eRBPHRiOOQkhQj/CuY/JEphadBJNCunbuPUmWabtdea1mdCcZN8/i2eQxF2jmBmB+eP5kOBi75rpVeOFzO6f4rsPCN00T9o4PdvimhECp61Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pelago.org.uk; spf=pass smtp.mailfrom=pelago.org.uk; dkim=pass (2048-bit key) header.d=pelago.org.uk header.i=@pelago.org.uk header.b=XDNrlPVK; arc=none smtp.client-ip=46.235.224.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pelago.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pelago.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=pelago.org.uk; s=mythic-beasts-k1; h=From:To:Subject:Date;
	bh=x3VT+5iyicJEVrdyWbzkEK72fKPATPivo6/EvwZumBw=; b=XDNrlPVKHWbauR5caD5Hsk9xJs
	m5fG/kzn/NXDY7GbTEOvIfc6eSxmb846M90d/mDs5vRkm7kWIf4M/nEDcwvTkk+zOxRrH3FYyBTGN
	iRwp69DT9dvhFuw/WeBMDWmqeJ1eKlD5YCH2GXJxB/FDlIPOUyGzcNahrWFg1LWhm/5ee78FkxMEH
	JJwJOyIeBaoiSIlcnauLeFz1KC5p4+BP2ioY47I2THZgkS96g9e+Shg5C2YTwmNuBGnDhbR1fncmf
	S1bliDBFLTgnmC//0wOYAFJ0ILJ+oQPZWIYRfCpkRBUK9VVwpW3KWZm20NCDK9rhd+fFV2PkRFtxb
	JOAFxwTw==;
Received: by mailhub-cam-d.mythic-beasts.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <john-linux@pelago.org.uk>)
	id 1wThvE-00Ddc3-2t;
	Sun, 31 May 2026 16:17:53 +0100
Message-ID: <75398536-2ca8-4205-9205-18afc5227397@pelago.org.uk>
Date: Sun, 31 May 2026 16:17:24 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] Toshiba Fn keys + lidswitch
To: johannes.goede@oss.qualcomm.com, "Rafael J. Wysocki" <rafael@kernel.org>,
 Nick <nick@kousu.ca>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 regressions@lists.linux.dev, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 todd.e.brandt@linux.intel.com, xi.pardee@linux.intel.com,
 platform-driver-x86@vger.kernel.org, stable@vger.kernel.org
References: <E2OXET.4X5GTP37VTNC3@kousu.ca>
 <CAJZ5v0jVQyWYqPo_MiUwNQb7FLNR_Q_++Xq=xA1owcHpcjN=OA@mail.gmail.com>
 <bc9d5258-d4df-46a1-bba9-de3486f722ab@pelago.org.uk>
 <8503d297-68ca-4bfe-bbdf-537a85890d86@oss.qualcomm.com>
Content-Language: en-GB
From: John Veness <john-linux@pelago.org.uk>
In-Reply-To: <8503d297-68ca-4bfe-bbdf-537a85890d86@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-BlackCat-Spam-Score: 0
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[pelago.org.uk:s=mythic-beasts-k1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[pelago.org.uk];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259357-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[pelago.org.uk:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[john-linux@pelago.org.uk,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,pelago.org.uk:mid,pelago.org.uk:dkim]
X-Rspamd-Queue-Id: 2AA9E616C9B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 30/05/2026 14:34, johannes.goede@oss.qualcomm.com wrote:
> In case you've not seen it yet, Rafael send out the test patch
> publicly later that day in another email in this thread:
> 
> https://lore.kernel.org/linux-acpi/12896447.O9o76ZdvQC@rafael.j.wysocki/
> 
> Regards,
> 
> Hans

Thanks for the pointer, and sorry for missing that! I had only been
looking in the archives of platform-driver-x86@vger.kernel.org which for
some reason didn't receive the patch.

John

