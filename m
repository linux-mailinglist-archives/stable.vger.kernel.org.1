Return-Path: <stable+bounces-210085-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CF13D3841C
	for <lists+stable@lfdr.de>; Fri, 16 Jan 2026 19:18:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E255C30BC947
	for <lists+stable@lfdr.de>; Fri, 16 Jan 2026 18:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79693399A66;
	Fri, 16 Jan 2026 18:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="HJI+doEe"
X-Original-To: stable@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65E9379998;
	Fri, 16 Jan 2026 18:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768587451; cv=none; b=Im4vgTXFRcIjFLFXhCaBO5LyuWK4Z8zIh756feYjnCiZeoIZyPrqgvslmxNjgIlpJsuawqJsjfxTnDWpc5QEE+45/il2EzMt5L7DcMQnCKZr3/6KBvHMmnaU9YZNkqrnmSUvkcurEDvrEwL+zZYZEhWhzTWfTUCqbyxHhF0Qn7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768587451; c=relaxed/simple;
	bh=0nJQ8AytPuHp8n4vp3V4k/WUs6dq/VmGYc+P16AUFh8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZWreiDCqsR+xEOSFEOMZdgOvMOEstjtuzKvtgjnl/Fwp11qeUHeBrTH2JF2rQT+5SCX70yXCNGwnq7Tj/a/IHoUNjtWSzrQDh3mksi3PzmO7gpz37Ny59IejIlolgdln46Nj0xThHjorTnXfTrpppHIPGALmdodOKxMTYlBFNiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=HJI+doEe; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net F18D440425
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1768587449; bh=bBP4jDjQBcNXzTw7ZJS5fB7BP3dYfgPD+FhTXLpoUsU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=HJI+doEeZMwiMq5txV5b/MEIXVfaEzsksE+X/mcsdazgKIPlBr+tSPm/yvGWJRIPo
	 GdOZhyThTTzpctvDTQk0RT6kAn9OLfo9bB1kLRmSVI4EGPMOKDHebluS8na4WVtakU
	 G5hQ83j9kLce6wU/lwneOoENmgQf9sb+QWRVDgtkNc435sHr0eQnCGXu1WHjd1BKOP
	 WDDurrIZ2pFU36gSM4ScuI2Fjahk4ns0k9iF4Bx2vHF57rISyo+0Ag/e/Rgb13ubg0
	 ep/m1lgIu+Lsh3ecldEMDQJfwhQGVNxPdTUaJ2CSCgNnrq8mSwyH6eEjXBUq/QIm0K
	 081MDVtE3X5tQ==
Received: from localhost (unknown [IPv6:2601:280:4600:27b::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id F18D440425;
	Fri, 16 Jan 2026 18:17:28 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Randy Dunlap <rdunlap@infradead.org>, Mauro Carvalho Chehab
 <mchehab+huawei@kernel.org>, Linux Doc Mailing List
 <linux-doc@vger.kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-kernel@vger.kernel.org, Jani Nikula <jani.nikula@intel.com>, Shuah
 Khan <skhan@linuxfoundation.org>, stable@vger.kernel.org
Subject: Re: [PATCH v4 2/4] scripts/kernel-doc: avoid error_count overflows
In-Reply-To: <79bb75da-5233-46d8-9590-7443806e2bd7@infradead.org>
References: <cover.1768395332.git.mchehab+huawei@kernel.org>
 <68ec6027db89b15394b8ed81b3259d1dc21ab37f.1768395332.git.mchehab+huawei@kernel.org>
 <79bb75da-5233-46d8-9590-7443806e2bd7@infradead.org>
Date: Fri, 16 Jan 2026 11:17:28 -0700
Message-ID: <87ecnpo213.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Randy Dunlap <rdunlap@infradead.org> writes:

> Mauro,
> The line formatting is weird on one line below
> (looks like 2 text lines are joined).
>
> On 1/14/26 4:57 AM, Mauro Carvalho Chehab wrote:
>> The glibc library limits the return code to 8 bits. We need to
>> stick to this limit when using sys.exit(error_count).
>> 
>> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
>> Cc: stable@vger.kernel.org
>> ---
>>  scripts/kernel-doc.py | 25 ++++++++++++++++++-------
>>  1 file changed, 18 insertions(+), 7 deletions(-)
>> 
>> diff --git a/scripts/kernel-doc.py b/scripts/kernel-doc.py
>> index 7a1eaf986bcd..3992ca49d593 100755
>> --- a/scripts/kernel-doc.py
>> +++ b/scripts/kernel-doc.py
>> @@ -116,6 +116,8 @@ SRC_DIR = os.path.dirname(os.path.realpath(__file__))
>>  
>>  sys.path.insert(0, os.path.join(SRC_DIR, LIB_DIR))
>>  
>> +WERROR_RETURN_CODE = 3
>> +
>>  DESC = """
>>  Read C language source or header FILEs, extract embedded documentation comments,
>>  and print formatted documentation to standard output.
>> @@ -176,7 +178,20 @@ class MsgFormatter(logging.Formatter):
>>          return logging.Formatter.format(self, record)
>>  
>>  def main():
>> -    """Main program"""
>> +    """
>> +    Main program
>> +    By default, the return value is:
>> +
>> +    - 0: success or Python version is not compatible with                                                                kernel-doc.  If -Werror is not used, it will also
>
> Here ^^^^^
>
Mauro, can you get me a clean copy?  It seems like we're more than ready
to apply this set otherwise...

Thanks,

jon

