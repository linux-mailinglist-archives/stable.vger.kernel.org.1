Return-Path: <stable+bounces-39960-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89EEF8A5BC9
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 21:56:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 392671F26750
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 19:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC9C313AA31;
	Mon, 15 Apr 2024 19:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="NQLHdeH7"
X-Original-To: stable@vger.kernel.org
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73216156240
	for <stable@vger.kernel.org>; Mon, 15 Apr 2024 19:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713210735; cv=none; b=uDc03Cs4ppbGNFdfklTYnF5p46NNceRA9t1ft6D8qelQ/dbeslKoXgYDwaVdo1VgwUkcHtFZu5bO6U8S/FDQEYaxtHS1Lg/bbfRuMhm82D2cGlsdf9FE2BYNRWISlULF1+sOu1trm1/Cw6HV837knSoyikfRMevoSBN7/YVqiXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713210735; c=relaxed/simple;
	bh=nPwkIw6EfhV0ArpberI8YyPI1zvME5g5rbrwFaH+s3Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ek68lASEgyuujhtTzrBvs81aka6lb/l8Fidf4NesVTmr0UlcA7bEPJsK6CSNEUyn8ftJFSKEv8UDKhjEE1yCPk+BIc9camiV+1DL5+093xdO4AuSYbI0jd/S9NJfyt2XOSb+uTRa22xF5hTWODKfNrCJAfWSTSukRPkiHs6prXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=NQLHdeH7; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4VJHrC4qlRzlgTHp;
	Mon, 15 Apr 2024 19:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1713210730; x=1715802731; bh=nPwkIw6EfhV0ArpberI8YyPI
	1zvME5g5rbrwFaH+s3Q=; b=NQLHdeH7EQubmGpcT6lo84H+f2I3KEO08IwjTCiY
	FdhokodUpWzN6H50YPpxocu4hwFFyJJMeW8HwHgG37qx9vDlWQWZ41mcJr+Fvw/x
	QIz/sB/KJqrpjIy0w8dlrxhh7N7a45iuXCaWpaqmZwg+FqKFXAFyr39OsAwjW0ZE
	myZnmBDx5WksZSlZSXNDVMCNRV50i178zo25gYIh67kqabHoa/lTvQmBk5JmDC3T
	OdBkGQaqlM3S8hDJBdGYcFujy4tLjTBUJWTGwcZzBx/XpLY+d/1AwAOHNlV3v0sJ
	B9ljPnhoBlef1qnrhn5/tc6dpJ4ZUF56bmA166s+yBR/Yg==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id tyQEht_SQKRH; Mon, 15 Apr 2024 19:52:10 +0000 (UTC)
Received: from [100.96.154.26] (unknown [104.132.0.90])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4VJHr92yFxzlgTsK;
	Mon, 15 Apr 2024 19:52:09 +0000 (UTC)
Message-ID: <7a32a48b-65fd-4452-8b86-0c29ded9a014@acm.org>
Date: Mon, 15 Apr 2024 12:52:08 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dm: Change the default value of rq_affinity from 0 into 1
To: Mike Snitzer <snitzer@redhat.com>
Cc: dm-devel@redhat.com, Mikulas Patocka <mpatocka@redhat.com>,
 Eric Biggers <ebiggers@kernel.org>, Jaegeuk Kim <jaegeuk@kernel.org>,
 Daniel Lee <chullee@google.com>, stable@vger.kernel.org
References: <20240415193448.4193512-1-bvanassche@acm.org>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240415193448.4193512-1-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Please ignore this message because the mailing list address is wrong.

Thanks,

Bart.

