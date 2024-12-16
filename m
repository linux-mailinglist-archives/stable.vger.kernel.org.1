Return-Path: <stable+bounces-104391-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BC5A9F38A7
	for <lists+stable@lfdr.de>; Mon, 16 Dec 2024 19:17:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A36411892E1C
	for <lists+stable@lfdr.de>; Mon, 16 Dec 2024 18:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2B3D20765E;
	Mon, 16 Dec 2024 18:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kolumbus.fi header.i=@kolumbus.fi header.b="OkiF/ewT"
X-Original-To: stable@vger.kernel.org
Received: from fgw23-4.mail.saunalahti.fi (fgw23-4.mail.saunalahti.fi [62.142.5.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99129207667
	for <stable@vger.kernel.org>; Mon, 16 Dec 2024 18:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734372535; cv=none; b=MspYZdcXmBNVmSOY2RzDdeFRcxahX+8o6ZXeat2AULU+AJN0/DyXMPwlHSEzM0xFeeXxDq8qS6RTer0jzdKBB+M7Ev0lkWeSvkc9oK9B3Q+2LTgrVIYnpDS7Anb7wV1goufiuoO58eaTDUxH2R77SYroA5xO88zbZSv5okDHc6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734372535; c=relaxed/simple;
	bh=ymUQw7TcAcLYagTrl0M58TxhLCi5oUlpFIoqUijHyhQ=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=A45x8zqhGwPXjiwDewgqLSWWRviEPeqF/sEEY2ZcOz5Mn94xyKnOTqDGtPk3KEFxeX7HMtDMOxpzlyOFsU65SFfTF2j2/SFEvHdFeUrHS3hqkojWr8GmXKhqd1F1C+q+ZNeEPFTo+rjVSTuIubcBvzOdxC1fCSFYGUb/j2r4GCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kolumbus.fi; spf=pass smtp.mailfrom=kolumbus.fi; dkim=pass (2048-bit key) header.d=kolumbus.fi header.i=@kolumbus.fi header.b=OkiF/ewT; arc=none smtp.client-ip=62.142.5.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kolumbus.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kolumbus.fi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=kolumbus.fi; s=elisa1;
	h=to:references:message-id:content-transfer-encoding:cc:date:in-reply-to:from:
	 subject:mime-version:content-type:from:to:cc:reply-to:subject:date:in-reply-to:
	 references:list-archive:list-subscribe:list-unsubscribe:content-type:
	 content-transfer-encoding:message-id;
	bh=gMaeYAlGvPFkwn95e686zQ2JBQMyimcVkSkxhn8q0eo=;
	b=OkiF/ewTVj9tNEqrKsc2wsUpWOwOSsxC/5rBoeqMHJHsr9AmfA9LCGsXYC26H2dCWHdHZ332WmmKf
	 VZzL1GxurALTlNypenfx2kXJe6sM3cSajCJpHrnLoSaZwbfewyvgS4Geq4KF+7DI2aPqS+ODfB2FYf
	 927emNRHeCnYEKt6WGCMkyuYpIZJLHp1GVeWI5yPO4yQ7HmaBcDfnWRCqPRrCBjLRoxRwIjhx6ob4D
	 LoEf7noSYozPuVcNBNXBOMcr5O24Fc04pPK2aTGbIuo1gmlNBe8GSxyCf2g92N4ajXTLOOVJI5yD1N
	 ab/7YGjnF/7HEX9frmBP7tu2GBypQkA==
Received: from smtpclient.apple (85-156-116-90.elisa-laajakaista.fi [85.156.116.90])
	by fgw20.mail.saunalahti.fi (Halon) with ESMTPSA
	id c864c142-bbd8-11ef-9c2f-005056bd6ce9;
	Mon, 16 Dec 2024 20:08:42 +0200 (EET)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.300.87.4.3\))
Subject: Re: [PATCH] scsi: st: Regression fix: Don't set pos_unknown just
 after device recognition
From: =?utf-8?B?IkthaSBNw6RraXNhcmEgKEtvbHVtYnVzKSI=?= <kai.makisara@kolumbus.fi>
In-Reply-To: <89a972a4-64e3-4fdb-b2ce-994469546bee@acm.org>
Date: Mon, 16 Dec 2024 20:08:31 +0200
Cc: linux-scsi@vger.kernel.org,
 jmeneghi@redhat.com,
 martin.petersen@oracle.com,
 "James.Bottomley@hansenpartnership.com" <James.Bottomley@HansenPartnership.com>,
 loberman@redhat.com,
 stable@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <AAE245CB-536B-4CF7-98DD-829026A439BA@kolumbus.fi>
References: <20241216113755.30415-1-Kai.Makisara@kolumbus.fi>
 <89a972a4-64e3-4fdb-b2ce-994469546bee@acm.org>
To: Bart Van Assche <bvanassche@acm.org>
X-Mailer: Apple Mail (2.3826.300.87.4.3)

On 16. Dec 2024, at 19.18, Bart Van Assche <bvanassche@acm.org> wrote:
>=20
> On 12/16/24 3:37 AM, Kai M=C3=A4kisara wrote:
>> diff --git a/drivers/scsi/st.h b/drivers/scsi/st.h
>> index 7a68eaba7e81..1aaaf5369a40 100644
>> --- a/drivers/scsi/st.h
>> +++ b/drivers/scsi/st.h
>> @@ -170,6 +170,7 @@ struct scsi_tape {
>>   unsigned char rew_at_close;  /* rewind necessary at close */
>>   unsigned char inited;
>>   unsigned char cleaning_req;  /* cleaning requested? */
>> + unsigned char first_tur;     /* first TEST UNIT READY */
>>   int block_size;
>>   int min_block;
>>   int max_block;
>=20
> Why 'unsigned char' instead of 'bool'?

For historical reasons I used the same type as in the other options.
(I happen to have 1.3.30 sources from 1995. The flags in st.h are
unsigned chars there. AFAIK, the type bool was introduces in C99
in 1999.)

> Should perhaps all 'unsigned char' occurrences in struct scsi_tape be
> changed into 'bool'? I'm not aware of any other Linux kernel code that
> uses the type 'unsigned char' for boolean values.

This also came into my mind, but this is a regression fix and I tried
to keep it minimal.

A patch to change the types can be done later.

Thanks,
Kai


