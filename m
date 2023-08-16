Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F47077EDE5
	for <lists+stable@lfdr.de>; Thu, 17 Aug 2023 01:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347187AbjHPXnn (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 16 Aug 2023 19:43:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347185AbjHPXnT (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 16 Aug 2023 19:43:19 -0400
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7197E56;
        Wed, 16 Aug 2023 16:43:18 -0700 (PDT)
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-686be3cbea0so266881b3a.0;
        Wed, 16 Aug 2023 16:43:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692229398; x=1692834198;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C+al/uns7Mj/j1eeauJBDRlosu2yd/IAjnaAqltgPxc=;
        b=IYvSA5lAqvvKJsErY613+TwlOwZvlFqeaXyfX09L5Jl/gMByip4dhedqb21Y0Vmm0z
         FdXKz6sbon2BakLPWRsTP5Wv5VUf6txlvgRTWR8Cf5MyG39MP1iWlpWcE69Rno86TEAC
         iImKNqTCUks3yOaYEiqSLQP/kxRK1DfEzRVcNEctMgxOKj2GOCB+o8wVgCIhTDKRvhMN
         qDFJDBsEMudTFQ5vTArEYxmdvV/+07XVhpS4KMCKcP75s6rNfuMjL6SNtsN0/cMfLRdr
         i1qx/IQqNLv7om/2dAGX6P7XpJoTuIpG3XVqflBzMbsezLHNAFMY2iQh/YxqbVByaT/8
         VbCA==
X-Gm-Message-State: AOJu0YznYmhwEPXJFEUbn/dwXSPATd4KbHTKxSUYWVWA31J5n0/SVpGi
        tZGtDCgSI7O/06SS7nMBcsw=
X-Google-Smtp-Source: AGHT+IEi08LNdPxlNyWGLV/p1WibxJbrIBtrarN7EJujqGleoNTcg6HblQ9L/r16U4diSFTo7/x/iw==
X-Received: by 2002:a05:6a00:134d:b0:688:47d5:ede with SMTP id k13-20020a056a00134d00b0068847d50edemr1088337pfu.6.1692229397906;
        Wed, 16 Aug 2023 16:43:17 -0700 (PDT)
Received: from ?IPV6:2601:647:5f00:5f5:4a46:e57b:bee0:6bc6? ([2601:647:5f00:5f5:4a46:e57b:bee0:6bc6])
        by smtp.gmail.com with ESMTPSA id d20-20020aa78694000000b006889348ba6esm1424537pfo.127.2023.08.16.16.43.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Aug 2023 16:43:17 -0700 (PDT)
Message-ID: <f68ae375-d55b-f377-3d76-f71ac40f64c2@acm.org>
Date:   Wed, 16 Aug 2023 16:43:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 1/3] scsi: core: Fix the scsi_set_resid() documentation
To:     Benjamin Block <bblock@linux.ibm.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>,
        Hannes Reinecke <hare@suse.de>,
        Douglas Gilbert <dgilbert@interlog.com>,
        stable@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Steffen Maier <maier@linux.ibm.com>,
        John Garry <john.g.garry@oracle.com>
References: <20230721160154.874010-1-bvanassche@acm.org>
 <20230721160154.874010-2-bvanassche@acm.org>
 <20230816095816.GA9823@p1gen4-pw042f0m.fritz.box>
Content-Language: en-US
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230816095816.GA9823@p1gen4-pw042f0m.fritz.box>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 8/16/23 02:58, Benjamin Block wrote:
> On Fri, Jul 21, 2023 at 09:01:32AM -0700, Bart Van Assche wrote:
>> Because scsi_finish_command() subtracts the residual from the buffer
>> length, residual overflows must not be reported. Reflect this in the
>> SCSI documentation. See also commit 9237f04e12cc ("scsi: core: Fix
>> scsi_get/set_resid() interface")
>>
>> Cc: Damien Le Moal <dlemoal@kernel.org>
>> Cc: Hannes Reinecke <hare@suse.de>
>> Cc: Douglas Gilbert <dgilbert@interlog.com>
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
>> ---
>>   Documentation/scsi/scsi_mid_low_api.rst | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/scsi/scsi_mid_low_api.rst b/Documentation/scsi/scsi_mid_low_api.rst
>> index 6fa3a6279501..022198c51350 100644
>> --- a/Documentation/scsi/scsi_mid_low_api.rst
>> +++ b/Documentation/scsi/scsi_mid_low_api.rst
>> @@ -1190,11 +1190,11 @@ Members of interest:
>>   		 - pointer to scsi_device object that this command is
>>                      associated with.
>>       resid
>> -		 - an LLD should set this signed integer to the requested
>> +		 - an LLD should set this unsigned integer to the requested
>>                      transfer length (i.e. 'request_bufflen') less the number
>>                      of bytes that are actually transferred. 'resid' is
>>                      preset to 0 so an LLD can ignore it if it cannot detect
>> -                   underruns (overruns should be rare). If possible an LLD
>> +                   underruns (overruns should not be reported). An LLD
> 
> I'm very late to party, sorry. But we have certainly seen at least one
> overrun reported some years ago on a FC SAN. We've changed some handling
> in zFCP due to that (
> a099b7b1fc1f ("scsi: zfcp: add handling for FCP_RESID_OVER to the fcp ingress path")
> ). The theory back than was, that it was cause by either a faulty ISL in
> the fabric, or some other "bit-errors" on the wire that caused some FC
> frames being dropped during transmit.
> 
> I added that we mark such commands with `DID_ERROR`, so they are
> retried, if that is permissible.
> 
>>                      should set 'resid' prior to invoking 'done'. The most
>>                      interesting case is data transfers from a SCSI target
>>                      device (e.g. READs) that underrun.
> 

Thanks, that's interesting feedback. Feel free to submit a patch that 
refines the scsi_set_resid() documentation further.

Bart.
