Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE8D174ADBB
	for <lists+stable@lfdr.de>; Fri,  7 Jul 2023 11:22:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbjGGJWO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 7 Jul 2023 05:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjGGJWO (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 7 Jul 2023 05:22:14 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 300B8172B
        for <stable@vger.kernel.org>; Fri,  7 Jul 2023 02:22:13 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3674tnbG015159;
        Fri, 7 Jul 2023 09:22:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : from : to : cc : subject : content-type :
 content-transfer-encoding; s=qcppdkim1;
 bh=NLCY0xYL9bLs4JhhOFyEX92l4TNoJhI/D0HV0kphidg=;
 b=mPgKC2XvbSHxFFDiWjToFHQrm5WFC+pATvJh8zGZoS9EPq47aIMJa61sC6KkHdJ2wDhl
 xhGGvwX1VEblynoXD1zmJuBaJ4HDB26tJ+4vBdRgH8MbvqIJ/n3f2gsoecYOTzgP7X5Q
 kj35xEWkMur2JqTMdWw1qGZjHfctwCoZ+XpejcRlL2iM6pXHXV0SZflGNccn+Z5ZbPv4
 H/83i+OVUp1BnfDGCDfzuSttUBux7P9Gm2JyyvN4U5UmgYRwDm74F6p7njQ7yotKCjF4
 Gucbvj8XMa4guo8IcXA46D9jxIIupmW8cDrpSfJHOm0Ibganh4Vdk5C3EMOcZkrapNxN Iw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rnx4x27v4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Jul 2023 09:22:09 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3679M846010306
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 7 Jul 2023 09:22:08 GMT
Received: from [10.214.66.119] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Fri, 7 Jul
 2023 02:22:07 -0700
Message-ID: <b606c4f7-1e47-6c26-c73d-7facaff5e469@quicinc.com>
Date:   Fri, 7 Jul 2023 14:52:03 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Content-Language: en-US
From:   Charan Teja Kalla <quic_charante@quicinc.com>
To:     <stable@vger.kernel.org>
CC:     <gregkh@google.com>, Johannes Weiner <hannes@cmpxchg.org>
Subject: backport d8c47cc7bf602ef73384a00869a70148146c1191 to linux-5.15.y
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: JWnYz5FxRkp2d5FWNymYkexHtR2rrRQ1
X-Proofpoint-GUID: JWnYz5FxRkp2d5FWNymYkexHtR2rrRQ1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-07_06,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 mlxscore=0 malwarescore=0
 suspectscore=0 clxscore=1011 spamscore=0 mlxlogscore=570 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307070086
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi,

Can you please help in back porting the below patch to linux-5.15.y
stable tree:
commit d8c47cc7bf602ef73384a00869a70148146c1191("mm: page_io: fix psi
memory pressure error on cold swapins") .

With the absence of this patch we are seeing some user space tools, like
Android low memory killer based on PSI events, bit aggressive as it
makes the PSI is accounted for even cold swapin on a device where swap
is mounted on a zram with slower backing dev.

Thanks,
Charan

