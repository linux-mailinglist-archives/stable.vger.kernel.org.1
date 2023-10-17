Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C3E37CCFFA
	for <lists+stable@lfdr.de>; Wed, 18 Oct 2023 00:23:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbjJQWXD (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 17 Oct 2023 18:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbjJQWXD (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 17 Oct 2023 18:23:03 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D0D7C6
        for <stable@vger.kernel.org>; Tue, 17 Oct 2023 15:23:00 -0700 (PDT)
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39HMMCuq020832
        for <stable@vger.kernel.org>; Tue, 17 Oct 2023 22:23:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=wUVliFzPgO7fUv1cpDyxdApfTLxbyMnDRZ0zUqT35Q8=;
 b=UMUIm58ftOpn/HHjPna8Hx5tvfvI7JgVhyNYV8I1p22BT0Y25BsX76UCg6stn4mpLI2R
 Y4jrMxlt8RN0Noy/DJAzhlm2Y+QS13VB58c1StWTKR0LFkpiO3VK2hkYq6TRIHogbSsK
 wx8q59sNUGvXuQI8McZifmbZbr3pTDR17X6zeJnZljbQSRtWacgyKBS30Pf+FDzNrBhL
 2GwMmu735fT+bXYv8ubQ2YHEDy7uJBhSsZ1BzKZ9DCel5WYJiPZRp2x57A6FV15XytUf
 MV4nH1cI4YEF35AFdAQd4K8Ev5G/CDeVxIVsbg3tb8TOiODTdlbYOXZvagEQocGHC5QW og== 
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tt30k80xt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <stable@vger.kernel.org>; Tue, 17 Oct 2023 22:22:59 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
        by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 39HKPXnu020300
        for <stable@vger.kernel.org>; Tue, 17 Oct 2023 22:22:59 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
        by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tr811kq0m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <stable@vger.kernel.org>; Tue, 17 Oct 2023 22:22:59 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
        by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39HMMuLm49283728
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Oct 2023 22:22:56 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3ED0F58055;
        Tue, 17 Oct 2023 22:22:56 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4CD785804B;
        Tue, 17 Oct 2023 22:22:55 +0000 (GMT)
Received: from li-2c1e724c-2c76-11b2-a85c-ae42eaf3cb3d.ibm.com.com (unknown [9.61.47.87])
        by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 17 Oct 2023 22:22:55 +0000 (GMT)
From:   Tony Krowiak <akrowiak@linux.ibm.com>
To:     kvm390-list@tuxmaker.boeblingen.de.ibm.com
Cc:     freude@linux.ibm.com, pasic@linux.vnet.ibm.com,
        borntraeger@de.ibm.com, fiuczy@linux.ibm.com,
        jjherne@linux.ibm.com, mjrosato@linux.ibm.com,
        stable@vger.kernel.org
Subject: [RFC 0/7] s390/vfio-ap: reset queues removed from guest's AP configuration
Date:   Tue, 17 Oct 2023 18:22:47 -0400
Message-ID: <20231017222254.68457-1-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: da7zSus8njf-G21UeaBpq9Ek4TfLQ_cI
X-Proofpoint-ORIG-GUID: da7zSus8njf-G21UeaBpq9Ek4TfLQ_cI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-17_06,2023-10-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 malwarescore=0 clxscore=1011 mlxscore=0 phishscore=0
 suspectscore=0 impostorscore=0 spamscore=0 mlxlogscore=781
 lowpriorityscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2309180000 definitions=main-2310170189
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

This patch series was ultimately created to fix a bug reported via
BZ203687. Halil did some problem determination and concluded that the
problem was due to the fact that all queues removed from the guest's AP
configuration are not reset. For example, when an adapter or domain is
assigned to the mdev matrix, if a queue device associated with the adapter
or domain is not bound to the vfio_ap device driver, the adapter to which
the queue is attached will be removed from the guest's configuration. The
problem is, removing the adapter also implicitly removes all queues 
attached to that adapter. Those queues also need to be reset to avert
leaking crypto data should any of those queues get assigned to another
guest or back to the host.

The original intent was to ensure that all queues removed from a guest's
AP configuration get reset. The testing included permutations of various
scenarios involving the binding/unbinding of queues either manually, or 
due to dynamic host AP configuration changes initiated via an SE or HMC 
attached to a DPM-enabled LPAR. This testing revealed several issues that
are also addressed via this patch series.

Note that several of the patches has a 'Fixes:' tag as well as a
Cc: <stable@vger.kernel.org> tag. I'm not sure whether this is necessary
because the patches not related to the reset issue are probably rarely
if ever encountered, so I'd like an opinion on that also.   

Tony Krowiak (7):
  s390/vfio-ap: always filter entire AP matrix
  s390/vfio-ap: circumvent filtering for adapters/domains not in host
    config
  s390/vfio-ap: do not reset queue removed from host config
  s390/vfio-ap: let 'on_scan_complete' callback filter matrix and update
    guest's APCB
  s390/vfio-ap: allow reset of subset of queues assigned to matrix mdev
  s390/vfio-ap: reset queues filtered from the guest's AP config
  s390/vfio-ap: reset queues associated with adapter for queue unbound
    from driver

 drivers/s390/crypto/vfio_ap_ops.c     | 294 +++++++++++++++++++-------
 drivers/s390/crypto/vfio_ap_private.h |  25 ++-
 2 files changed, 234 insertions(+), 85 deletions(-)

-- 
2.41.0

