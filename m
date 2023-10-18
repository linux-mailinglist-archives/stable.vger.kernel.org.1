Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F7E47CE344
	for <lists+stable@lfdr.de>; Wed, 18 Oct 2023 19:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbjJRRCY (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 18 Oct 2023 13:02:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjJRRCX (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 18 Oct 2023 13:02:23 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ADDCB0
        for <stable@vger.kernel.org>; Wed, 18 Oct 2023 10:02:22 -0700 (PDT)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39IGgHPJ030857
        for <stable@vger.kernel.org>; Wed, 18 Oct 2023 17:02:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=oZFGXOw+OPaVK2hvnuXzb+C5EwLlVt8Or92wxf73Bho=;
 b=dSMGWAdXt++0pWw2RGuOOMvEcslE46WlpmjX99nrN3edGzL5qYSdU+qCzwKBEyGJSOtq
 8A0Pe6Mu+9+aB1sS80a04puAIkmlYmxdt7o3xk9vaRNXL9QCrlDGD8EOraTGMLqosrro
 yH3mh41vAMFuH+6fp0F1Upb6SKRNNYCF08iJ4+5KDkwCNvjVFrQ/rjMkBeo+jq9/Fkzy
 WOXd3LU7094J4VFR42OLEha8eYqLPJfE1j3S1okXATbXSNCY2eWde/TLm1MItAPCoEtg
 LcKAAr33cGcfugjoz+OSMuYUSv74LKvmxXYLvfy4/jzbejP1XiG+3Zo8yUN+Y0OTZtiC DQ== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ttk470tgw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <stable@vger.kernel.org>; Wed, 18 Oct 2023 17:02:19 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 39IGF6Ud012871
        for <stable@vger.kernel.org>; Wed, 18 Oct 2023 17:01:47 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tr5pyjeu0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <stable@vger.kernel.org>; Wed, 18 Oct 2023 17:01:47 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39IH1gCv11534866
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Oct 2023 17:01:42 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 905352004F;
        Wed, 18 Oct 2023 17:01:42 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 516972004B;
        Wed, 18 Oct 2023 17:01:42 +0000 (GMT)
Received: from li-ce58cfcc-320b-11b2-a85c-85e19b5285e0 (unknown [9.152.224.212])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 18 Oct 2023 17:01:42 +0000 (GMT)
Date:   Wed, 18 Oct 2023 19:01:37 +0200
From:   Halil Pasic <pasic@linux.ibm.com>
To:     Tony Krowiak <akrowiak@linux.ibm.com>
Cc:     kvm390-list@tuxmaker.boeblingen.de.ibm.com, freude@linux.ibm.com,
        pasic@linux.vnet.ibm.com, borntraeger@de.ibm.com,
        fiuczy@linux.ibm.com, jjherne@linux.ibm.com,
        mjrosato@linux.ibm.com, stable@vger.kernel.org,
        Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [RFC 2/7] s390/vfio-ap: circumvent filtering for
 adapters/domains not in host config
Message-ID: <20231018190137.277682fe.pasic@linux.ibm.com>
In-Reply-To: <20231017222254.68457-3-akrowiak@linux.ibm.com>
References: <20231017222254.68457-1-akrowiak@linux.ibm.com>
        <20231017222254.68457-3-akrowiak@linux.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: YF1MoizdldsF8moGNiAM_0Ynbyr0HwG1
X-Proofpoint-GUID: YF1MoizdldsF8moGNiAM_0Ynbyr0HwG1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-18_15,2023-10-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 mlxscore=0 mlxlogscore=999 spamscore=0 malwarescore=0 adultscore=0
 clxscore=1011 priorityscore=1501 impostorscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310180139
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, 17 Oct 2023 18:22:49 -0400
Tony Krowiak <akrowiak@linux.ibm.com> wrote:

> While filtering the mdev matrix, it doesn't make sense - and will have
> unexpected results - to filter an APID from the matrix if the APID or one
> of the associated APQIs is not in the host's AP configuration. There are
> two reasons for this:
> 
> 1. An adapter or domain that is not in the host's AP configuration can be
>    assigned to the matrix; this is known as over-provisioning. Queue
>    devices, however, are only created for adapters and domains in the
>    host's AP configuration, so there will be no queues associated with an
>    over-provisioned adapter or domain to filter.
> 
> 2. The adapter or domain may have been externally removed from the host's
>    configuration via an SE or HMC attached to a DPM enabled LPAR. In this
>    case, the vfio_ap device driver would have been notified by the AP bus
>    via the on_config_changed callback and the adapter or domain would
>    have already been filtered.
> 
> Let's bypass the filtering of an APID if an adapter or domain assigned to
> the mdev matrix is not in the host's AP configuration.

I strongly agree.

> 
> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
> Fixes: 48cae940c31d ("s390/vfio-ap: refresh guest's APCB by filtering AP resources assigned to mdev")
> Cc: <stable@vger.kernel.org>
> ---
>  drivers/s390/crypto/vfio_ap_ops.c | 32 +++++++++++++++++++++++++------
>  1 file changed, 26 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
> index e5490640e19c..4e40e226ce62 100644
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> @@ -692,17 +692,37 @@ static bool vfio_ap_mdev_filter_matrix(struct ap_matrix_mdev *matrix_mdev)
>  		   (unsigned long *)matrix_dev->info.aqm, AP_DOMAINS);
> 
>  	for_each_set_bit_inv(apid, matrix_mdev->matrix.apm, AP_DEVICES) {

What speaks against doing the loop on matrix_mdev->shadow_apcb.a[pq]m?

Those are the and of matrix_mdev->matrix.a{p,q}m and
matrix_dev->info.a{p,q}m so excactly those bits are 0 for which you are adding
the ifs...

> +		/*
> +		 * If the adapter is not in the host's AP configuration, it will
> +		 * be due to one of two reasons:
> +		 * 1. The adapter is over-provisioned.
> +		 * 2. The adapter was removed from the host's
> +		 *    configuration in which case it will already have
> +		 *    been processed by the on_config_changed callback.
> +		 * In either case, we should skip the filtering and
> +		 * continue examining APIDs.
> +		 */
> +		if (!test_bit_inv(apid, (unsigned long *)matrix_dev->info.apm))
> +			continue;
> +
>  		for_each_set_bit_inv(apqi, matrix_mdev->matrix.aqm, AP_DOMAINS) {
>  			/*
> -			 * If the APQN is not bound to the vfio_ap device
> -			 * driver, then we can't assign it to the guest's
> -			 * AP configuration. The AP architecture won't
> -			 * allow filtering of a single APQN, so let's filter
> -			 * the APID since an adapter represents a physical
> -			 * hardware device.
> +			 * If the domain is not in the host's AP configuration,
> +			 * it will for one of two reasons:
> +			 * 1. The domain is over-provisioned.
> +			 * 2. The domain was removed from the host's
> +			 *    configuration in which case it will already have
> +			 *    been processed by the on_config_changed callback.
> +			 * In either case, we should skip the filtering and
> +			 * continue examining APQIs.
>  			 */
> +			if (!test_bit_inv(apqi,
> +					  (unsigned long *)matrix_dev->info.aqm))
> +				continue;
> +
>  			apqn = AP_MKQID(apid, apqi);
>  			q = vfio_ap_mdev_get_queue(matrix_mdev, apqn);
> +
>  			if (!q || q->reset_status.response_code) {
>  				clear_bit_inv(apid,
>  					      matrix_mdev->shadow_apcb.apm);

