Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF3257CE7E2
	for <lists+stable@lfdr.de>; Wed, 18 Oct 2023 21:39:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231354AbjJRTju (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 18 Oct 2023 15:39:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjJRTjt (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 18 Oct 2023 15:39:49 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C280122
        for <stable@vger.kernel.org>; Wed, 18 Oct 2023 12:39:48 -0700 (PDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39IJbgW6025198
        for <stable@vger.kernel.org>; Wed, 18 Oct 2023 19:39:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=5bw5twgt+M9rRsZdz8Su4W6nDiXCRw6ejvJ1/bktkyc=;
 b=FNmVVl7nVJ0wNNrrM0eTDsNQO+2Zanldvv9qa+pVUy3XadYJ8BpxiniDbxngBJxsUiXY
 jvUen0Ht5zMaxa5KBBu2rNFXrFxWu7WAcA6y1Il+wwNLhYcs9kwGujpZtLz2/Rrff8G8
 BaM8mp2D6xeLfT9R9kT87Sbu/bPo795KJjI9jlMir1uyyQM6YBRobcFjmiiGJ6wsjsyq
 bJHlM+0iSJZykmb1D6SEJBXyrumF9S/5Mj/QXKNdFgz7M2J7c8VpwbJS81s9nKsUdtUY
 I9+r1arfF2uOHw0SWlsLQTutea5+1qhA91YBfzMJozmu0yT1eA578yv8dSReNeB60sQ4 FQ== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ttnpcg21m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <stable@vger.kernel.org>; Wed, 18 Oct 2023 19:39:47 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 39IJNmKK027149
        for <stable@vger.kernel.org>; Wed, 18 Oct 2023 19:39:46 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
        by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tr6tkk9r7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <stable@vger.kernel.org>; Wed, 18 Oct 2023 19:39:46 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
        by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39IJdhwS4522728
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Oct 2023 19:39:43 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 37D9758063;
        Wed, 18 Oct 2023 19:39:43 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AE3FA58069;
        Wed, 18 Oct 2023 19:39:41 +0000 (GMT)
Received: from [9.61.163.143] (unknown [9.61.163.143])
        by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 18 Oct 2023 19:39:41 +0000 (GMT)
Message-ID: <31256029-a17e-835f-172d-6a9a0e528c5d@linux.ibm.com>
Date:   Wed, 18 Oct 2023 15:39:41 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC 2/7] s390/vfio-ap: circumvent filtering for adapters/domains
 not in host config
To:     Halil Pasic <pasic@linux.ibm.com>
Cc:     kvm390-list@tuxmaker.boeblingen.de.ibm.com, freude@linux.ibm.com,
        pasic@linux.vnet.ibm.com, borntraeger@de.ibm.com,
        fiuczy@linux.ibm.com, jjherne@linux.ibm.com,
        mjrosato@linux.ibm.com, stable@vger.kernel.org
References: <20231017222254.68457-1-akrowiak@linux.ibm.com>
 <20231017222254.68457-3-akrowiak@linux.ibm.com>
 <20231018190137.277682fe.pasic@linux.ibm.com>
Content-Language: en-US
From:   Tony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <20231018190137.277682fe.pasic@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 6CaZVggyf7FQ6jGk3gldvituRXnierwo
X-Proofpoint-ORIG-GUID: 6CaZVggyf7FQ6jGk3gldvituRXnierwo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-18_18,2023-10-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 mlxscore=0
 mlxlogscore=999 impostorscore=0 spamscore=0 suspectscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310180161
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org



On 10/18/23 13:01, Halil Pasic wrote:
> On Tue, 17 Oct 2023 18:22:49 -0400
> Tony Krowiak <akrowiak@linux.ibm.com> wrote:
> 
>> While filtering the mdev matrix, it doesn't make sense - and will have
>> unexpected results - to filter an APID from the matrix if the APID or one
>> of the associated APQIs is not in the host's AP configuration. There are
>> two reasons for this:
>>
>> 1. An adapter or domain that is not in the host's AP configuration can be
>>     assigned to the matrix; this is known as over-provisioning. Queue
>>     devices, however, are only created for adapters and domains in the
>>     host's AP configuration, so there will be no queues associated with an
>>     over-provisioned adapter or domain to filter.
>>
>> 2. The adapter or domain may have been externally removed from the host's
>>     configuration via an SE or HMC attached to a DPM enabled LPAR. In this
>>     case, the vfio_ap device driver would have been notified by the AP bus
>>     via the on_config_changed callback and the adapter or domain would
>>     have already been filtered.
>>
>> Let's bypass the filtering of an APID if an adapter or domain assigned to
>> the mdev matrix is not in the host's AP configuration.
> 
> I strongly agree.
> 
>>
>> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
>> Fixes: 48cae940c31d ("s390/vfio-ap: refresh guest's APCB by filtering AP resources assigned to mdev")
>> Cc: <stable@vger.kernel.org>
>> ---
>>   drivers/s390/crypto/vfio_ap_ops.c | 32 +++++++++++++++++++++++++------
>>   1 file changed, 26 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
>> index e5490640e19c..4e40e226ce62 100644
>> --- a/drivers/s390/crypto/vfio_ap_ops.c
>> +++ b/drivers/s390/crypto/vfio_ap_ops.c
>> @@ -692,17 +692,37 @@ static bool vfio_ap_mdev_filter_matrix(struct ap_matrix_mdev *matrix_mdev)
>>   		   (unsigned long *)matrix_dev->info.aqm, AP_DOMAINS);
>>
>>   	for_each_set_bit_inv(apid, matrix_mdev->matrix.apm, AP_DEVICES) {
> 
> What speaks against doing the loop on matrix_mdev->shadow_apcb.a[pq]m?
> 
> Those are the and of matrix_mdev->matrix.a{p,q}m and
> matrix_dev->info.a{p,q}m so excactly those bits are 0 for which you are adding
> the ifs...

You are correct, there is no good reason to avoid looping on the 
shadow_apcb. I'll change this patch to do just that.

> 
>> +		/*
>> +		 * If the adapter is not in the host's AP configuration, it will
>> +		 * be due to one of two reasons:
>> +		 * 1. The adapter is over-provisioned.
>> +		 * 2. The adapter was removed from the host's
>> +		 *    configuration in which case it will already have
>> +		 *    been processed by the on_config_changed callback.
>> +		 * In either case, we should skip the filtering and
>> +		 * continue examining APIDs.
>> +		 */
>> +		if (!test_bit_inv(apid, (unsigned long *)matrix_dev->info.apm))
>> +			continue;
>> +
>>   		for_each_set_bit_inv(apqi, matrix_mdev->matrix.aqm, AP_DOMAINS) {
>>   			/*
>> -			 * If the APQN is not bound to the vfio_ap device
>> -			 * driver, then we can't assign it to the guest's
>> -			 * AP configuration. The AP architecture won't
>> -			 * allow filtering of a single APQN, so let's filter
>> -			 * the APID since an adapter represents a physical
>> -			 * hardware device.
>> +			 * If the domain is not in the host's AP configuration,
>> +			 * it will for one of two reasons:
>> +			 * 1. The domain is over-provisioned.
>> +			 * 2. The domain was removed from the host's
>> +			 *    configuration in which case it will already have
>> +			 *    been processed by the on_config_changed callback.
>> +			 * In either case, we should skip the filtering and
>> +			 * continue examining APQIs.
>>   			 */
>> +			if (!test_bit_inv(apqi,
>> +					  (unsigned long *)matrix_dev->info.aqm))
>> +				continue;
>> +
>>   			apqn = AP_MKQID(apid, apqi);
>>   			q = vfio_ap_mdev_get_queue(matrix_mdev, apqn);
>> +
>>   			if (!q || q->reset_status.response_code) {
>>   				clear_bit_inv(apid,
>>   					      matrix_mdev->shadow_apcb.apm);
> 
