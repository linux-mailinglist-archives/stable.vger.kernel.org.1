Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73D2474B52C
	for <lists+stable@lfdr.de>; Fri,  7 Jul 2023 18:40:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbjGGQkc (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 7 Jul 2023 12:40:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232953AbjGGQkZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 7 Jul 2023 12:40:25 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4E682704
        for <stable@vger.kernel.org>; Fri,  7 Jul 2023 09:40:21 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 367CxBgn032413;
        Fri, 7 Jul 2023 16:40:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=iouLYmGYlZ0TgmBJgS+X1r15ZXXsqsiRItUhtuT6uTQ=;
 b=WwpEOG0jo8/CsAAFTUciewYDg0DAwe2Ui4wU8DKfzDUJUICqzVpkWn3imCg8m8dvTcY1
 aKsP22hVWhiXenuDKeQiRY9NWBxrIQFlCN8/bbzBNof1e/7ZgXtX8AzGj1VzEcU5SVPp
 Y1F1sYfKfQyZ9vA5GzRsirA/lzKu/aLwNpqShtWtqYTBX6MtHJAjJWzu/1UNX/IBt9iL
 wUx8ZFS7I5LK7SygtFF22dvJf49Ihw8c27O0XwupNS/Nxy/uBxxOOnXsVzhilMUWRmTX
 TrfuQr1DYzBKQiu/eDtg9y5XxYyjlif7v1Fz25TF0PizHJUBdPjby+G2UMgd/t3dzMn6 XA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rpdxw1get-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Jul 2023 16:40:19 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 367GeHBw011197
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 7 Jul 2023 16:40:17 GMT
Received: from [10.216.49.201] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Fri, 7 Jul
 2023 09:40:16 -0700
Message-ID: <5e6c0794-f13a-9ae6-d400-481d85fe00c6@quicinc.com>
Date:   Fri, 7 Jul 2023 22:10:11 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: backport d8c47cc7bf602ef73384a00869a70148146c1191 to linux-5.15.y
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     <stable@vger.kernel.org>, Johannes Weiner <hannes@cmpxchg.org>
References: <b606c4f7-1e47-6c26-c73d-7facaff5e469@quicinc.com>
 <2023070711-overstay-reclining-7443@gregkh>
From:   Charan Teja Kalla <quic_charante@quicinc.com>
In-Reply-To: <2023070711-overstay-reclining-7443@gregkh>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: oMIUfRg0GLQasRXcFruYxWNgu24I9gC4
X-Proofpoint-ORIG-GUID: oMIUfRg0GLQasRXcFruYxWNgu24I9gC4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-07_10,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=587 spamscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0
 clxscore=1011 mlxscore=0 bulkscore=0 suspectscore=0 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307070154
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi Greg,

On 7/7/2023 9:23 PM, Greg KH wrote:
>> Hi,
>>
>> Can you please help in back porting the below patch to linux-5.15.y
>> stable tree:
>> commit d8c47cc7bf602ef73384a00869a70148146c1191("mm: page_io: fix psi
>> memory pressure error on cold swapins") .
> This commit does not apply to the 5.15.y kernel at all, how did you test
> this?
There are couple of merge conflicts which is resolved and tested
locally.  When you asked me to just send the SHA1 key, I was mistaken
that resolving those merge conflicts also will be taken care :( .

I will send the back ported patch that is tested by following [1].

[1] https://www.kernel.org/doc/html/v6.1/process/stable-kernel-rules.html

> 
