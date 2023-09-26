Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99A267AF4D7
	for <lists+stable@lfdr.de>; Tue, 26 Sep 2023 22:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231899AbjIZUKd (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 26 Sep 2023 16:10:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjIZUKc (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 26 Sep 2023 16:10:32 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA7BD192
        for <stable@vger.kernel.org>; Tue, 26 Sep 2023 13:10:25 -0700 (PDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38QJabN7022252;
        Tue, 26 Sep 2023 20:10:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=g+3nzDY+6iPIVdg0GcX0AxiTUNU0DsX0xUDrqGI4DIs=;
 b=ejmsYIvC3R2Wwusl0wYvZIyKxRsTtwfOQhBxvhN1pqrfvRwSZcWGxfRbNxxUTldju8Yw
 nma2r/D1YLY6Zo72sNTjbH8xcPkUE1r5LbD1u2eHVnKcCQWN//ggEifIuqSp/Kghwwr2
 4oTTFaWD0bFYfmL2FqrZKM4HeKPr8Cy9Qpx92hBuG0XC7plUVA2lxDeLtkvpalIQg/FN
 3EQ2owZGlln5J3sL6WRevMW0fW/7J53NIY6u6RQgmCTb8xxl6uFNbExZVMcLe7bUoxfQ
 wgzXH+QuD6p547EJH41yP+uc8jwOFwM4+QtgvtS6a/itZhdDmSPyuGTuajRLr9ag+JmM ig== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tc4tba0ru-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Sep 2023 20:10:13 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38QJap5X023593;
        Tue, 26 Sep 2023 20:10:13 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tc4tba0q8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Sep 2023 20:10:12 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38QJFnK8008273;
        Tue, 26 Sep 2023 20:10:11 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
        by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tabbn62w3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Sep 2023 20:10:11 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
        by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38QKAA8w15860310
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Sep 2023 20:10:10 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A92E058062;
        Tue, 26 Sep 2023 20:10:10 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 344DD58057;
        Tue, 26 Sep 2023 20:10:10 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.107.17])
        by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 26 Sep 2023 20:10:10 +0000 (GMT)
Message-ID: <97802d8be17842774a07272cc4f59d34695c969b.camel@linux.ibm.com>
Subject: Re: [PATCH 5.4 118/367] ima: Remove deprecated IMA_TRUSTED_KEYRING
 Kconfig
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, Nayna Jain <nayna@linux.ibm.com>,
        Sasha Levin <sashal@kernel.org>,
        Oleksandr Tymoshenko <ovt@google.com>
Date:   Tue, 26 Sep 2023 16:10:09 -0400
In-Reply-To: <20230920112901.691830240@linuxfoundation.org>
References: <20230920112858.471730572@linuxfoundation.org>
         <20230920112901.691830240@linuxfoundation.org>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: JFU09qE1Dk5EbPAozDs2Fi5h4CObOJEk
X-Proofpoint-GUID: CVaPZJIBh8zW0morIMKRWo3G2DTOIi7k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-26_14,2023-09-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 malwarescore=0 clxscore=1011 spamscore=0 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=496 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309260172
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi Greg,

On Wed, 2023-09-20 at 13:28 +0200, Greg Kroah-Hartman wrote:
> 5.4-stable review patch.  If anyone has any objections, please let me know.

Thanks for holding off on back porting this. Oleksandr Tymoshenko's
"ima: Finish deprecation of IMA_TRUSTED_KEYRING Kconfig" is needed as
well.  

-- 
thanks,

Mimi

