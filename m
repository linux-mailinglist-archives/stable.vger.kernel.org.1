Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5B45702F3F
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 16:08:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240262AbjEOOI2 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 10:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240697AbjEOOIO (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 10:08:14 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F56B2137
        for <stable@vger.kernel.org>; Mon, 15 May 2023 07:08:03 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34FBAjuv012069;
        Mon, 15 May 2023 14:08:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=t31+xZ3ANxVVpT+jjfvoJACPd4NU8Cd8f+BFv3K1mFs=;
 b=R7glSo8URBTLRi46wAQa/F760T9YKH9Qzu1GTIfSmK1N0b+njlfhzH7DVgM3iLv5h5X/
 e9qxwUrP89/FO3qaM35KLJSuKuZA9GdT68NaLkhMVjy9sRWmR9ADkMtiuFDJmIt74Nns
 6c1Bsy5hHp2jlTaOHboNbwy6Eh8Dtb7NnI8lHeiCKf2VhQ49Gq+YPzKEI5kuv2QlMrsN
 r6pdqGpl93ifnoPWNWlEMEmo5Ro6eeYLubxmmw+gEApcpeUNAUbmcfTQ92G+q/BoqjvW
 JiqU+zgMveehOg6p6MUUHkwoNFmFa3shgCt2cfsLlztXEus52ge9gI3Htn4j7wbwh+pV nw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qkjwdrh92-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 May 2023 14:08:00 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34FE7xR3010678
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 May 2023 14:07:59 GMT
Received: from [10.226.59.182] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Mon, 15 May
 2023 07:07:59 -0700
Message-ID: <955b04f0-6976-be9f-b089-ff2fb6f9e5aa@quicinc.com>
Date:   Mon, 15 May 2023 08:07:58 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH 5.10.y] bus: mhi: host: Range check CHDBOFF and ERDBOFF
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     <stable@vger.kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
References: <2023050613-slacked-gush-009c@gregkh>
 <1683733522-13432-1-git-send-email-quic_jhugo@quicinc.com>
 <2023051536-ammonium-tropical-bfd9@gregkh>
From:   Jeffrey Hugo <quic_jhugo@quicinc.com>
In-Reply-To: <2023051536-ammonium-tropical-bfd9@gregkh>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: kDFf9V5vCWIipGF0NyQY1thzK8TGbT15
X-Proofpoint-GUID: kDFf9V5vCWIipGF0NyQY1thzK8TGbT15
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-15_11,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 mlxscore=0 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305150120
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 5/15/2023 6:46 AM, Greg KH wrote:
> On Wed, May 10, 2023 at 09:45:22AM -0600, Jeffrey Hugo wrote:
>> Commit 6a0c637bfee69a74c104468544d9f2a6579626d0 upstream.
>>
>> If the value read from the CHDBOFF and ERDBOFF registers is outside the
>> range of the MHI register space then an invalid address might be computed
>> which later causes a kernel panic.  Range check the read value to prevent
>> a crash due to bad data from the device.
>>
>> Fixes: 6cd330ae76ff ("bus: mhi: core: Add support for ringing channel/event ring doorbells")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
>> Reviewed-by: Pranjal Ramajor Asha Kanojiya <quic_pkanojiy@quicinc.com>
>> Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
>> Link: https://lore.kernel.org/r/1679674384-27209-1-git-send-email-quic_jhugo@quicinc.com
>> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>> ---
>>   drivers/bus/mhi/core/init.c | 12 ++++++++++++
>>   1 file changed, 12 insertions(+)
> 
> This breaks the build, did you test it?
> 

Checked the workspace and it is "working".  Recreated it from scratch, 
and I see the build failure.  Clearly I messed something up.

Will fix.  Sorry.

