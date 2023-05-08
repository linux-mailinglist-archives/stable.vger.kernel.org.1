Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A81616FB458
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 17:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234629AbjEHPtl (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 11:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234607AbjEHPt3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 11:49:29 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63FA2AD34;
        Mon,  8 May 2023 08:49:04 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 348EN0vI016491;
        Mon, 8 May 2023 15:48:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=pMDOnRPQL7YmdQOJS97Sctst8OApqW7yTB6sPnQWfkc=;
 b=gq2UQSInXUSwKHIoqiizGiMr8DFBbELKfVb85BJtUY8+0pUGaEyvEyJGwjSL972gOra0
 qNQZW6/nfzpjMaFvKvtr4mPaiBZkmpoCDUeijTd5nWqojOsXBPwtmk4yyVjXQa8CVkpF
 dVwkGGiHy5kGUl0UPa5PUXZ+nsEyazjKMHbdFFMntmx+6uCQ/M+PmjpcTzowCFqyV+Y9
 IALfYnSjiWs617SUteNB9U1qcCCCL2HTTqO1n9dsHa17o8xvHpm/jzrRxyQzEX2f200q
 QCHEEarr7kWCI1tgRLAlCphGvt5wZnDumEsDVzYnlYxl6ACDeeMkdzO68EIqyplCsXV9 ag== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qey390qk6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 May 2023 15:48:26 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 348FmP0N031336
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 8 May 2023 15:48:25 GMT
Received: from [10.216.34.27] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Mon, 8 May 2023
 08:48:21 -0700
Message-ID: <34a33b09-20aa-13e3-e4bd-c8b5854450a4@quicinc.com>
Date:   Mon, 8 May 2023 21:18:17 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v9] usb: dwc3: debugfs: Prevent any register access when
 devices is runtime suspended
Content-Language: en-US
To:     Johan Hovold <johan@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pratham Pratap <quic_ppratap@quicinc.com>,
        Jack Pham <quic_jackp@quicinc.com>,
        Johan Hovold <johan+linaro@kernel.org>,
        Oliver Neukum <oneukum@suse.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <20230505155103.30098-1-quic_ugoswami@quicinc.com>
 <20230506013036.j533xncixkky5uf6@synopsys.com>
 <ZFjePu8Wb6NUwCav@hovoldconsulting.com>
From:   Udipto Goswami <quic_ugoswami@quicinc.com>
In-Reply-To: <ZFjePu8Wb6NUwCav@hovoldconsulting.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: XIcO1z0pVEs39B5M9kqNrmCB3PaSElvF
X-Proofpoint-GUID: XIcO1z0pVEs39B5M9kqNrmCB3PaSElvF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-08_11,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 spamscore=0 suspectscore=0 bulkscore=0 malwarescore=0 adultscore=0
 mlxscore=0 mlxlogscore=787 lowpriorityscore=0 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305080103
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org



On 5/8/23 5:04 PM, Johan Hovold wrote:
> On Sat, May 06, 2023 at 01:30:52AM +0000, Thinh Nguyen wrote:
> 
> Udipto, looks like you just ignored my comment about fixing up the patch
> Subject.

Hi Johan,

Apologies for this, i missed the comment on the Subject will rectify it.

> 
>> On Fri, May 05, 2023, Udipto Goswami wrote:
>>> When the dwc3 device is runtime suspended, various required clocks would
>>> get disabled and it is not guaranteed that access to any registers would
>>> work. Depending on the SoC glue, a register read could be as benign as
>>> returning 0 or be fatal enough to hang the system.
>>>
>>> In order to prevent such scenarios of fatal errors, make sure to resume
>>> dwc3 then allow the function to proceed.
>>>
>>> Fixes: 62ba09d6bb63 ("usb: dwc3: debugfs: Dump internal LSP and ep registers")
>>
>> This fix goes before the above change.
> 
> Yes, this clearly is not the commit that first introduced this issue.
> 
> Either add a Fixes tag for the oldest one or add one for each commit
> that introduced debugfs attributes with this issues.
> 
>> This also touches on many places and is more than 100 lines. While this
>> is a fix, I'm not sure if Cc stable is needed. Perhaps others can
>> comment.
> 
> I believe this should be backported as it fixes a crash/hang.
> 
> The stable rules are flexible, but it may also be possible to break the
> patch up in pieces and add a corresponding Fixes tag.

Agree, I will add a fixes tag for the oldest change that introduced the 
debugfs attributes instead of breaking it to multiple patches and adding 
fixes for each one. (I think the present code changes can stay in one 
patch as we are fixing the same issue in all the functions).

Let me know if you think otherwise?

Thanks,
-Udipto
