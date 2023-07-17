Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F8047560C8
	for <lists+stable@lfdr.de>; Mon, 17 Jul 2023 12:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbjGQKo1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 17 Jul 2023 06:44:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbjGQKo0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 17 Jul 2023 06:44:26 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38F7811C
        for <stable@vger.kernel.org>; Mon, 17 Jul 2023 03:44:25 -0700 (PDT)
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36HAccnv000331
        for <stable@vger.kernel.org>; Mon, 17 Jul 2023 10:44:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=mime-version : date :
 from : to : cc : subject : reply-to : in-reply-to : references :
 message-id : content-type : content-transfer-encoding; s=pp1;
 bh=Q3aAgWLKGwgdIN2ZY4pUWxo44Fyc+ryz+Wz9Eg1YWhw=;
 b=n0EAv6FnDvyM7SlDVsEF6JJo7j8wbeYQpic0sY3FP0JK9U6Tx8lYjNoZMqSNzKBNenuV
 9ONQVWbCadYfnqGBfzGYfiIC58hpjmocN6Yn5oOZOWPzZ9rGVLXyK6IPIiQNJ95NoUoh
 UUN5mC3zNys2uMNxP9jUP0FnBjOqqcJknXT8owSusq8nNcJDXt1qBINJ0CWvwSFTszG9
 icxuYrP9AAfL85jOWG5mWdhYZfBBTZZFNKLa1z5wpLWVfnJIvjOC3/pH4I6cI3NWl9Kd
 xyM3hKZjKbF4mSkVHGXZiOBhmtovq6TnJ+OqUmDiYRkRr15uLrXvUXrkw0/uaHxOiozf rw== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rw3vu092v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <stable@vger.kernel.org>; Mon, 17 Jul 2023 10:44:24 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 36H81UC8003340
        for <stable@vger.kernel.org>; Mon, 17 Jul 2023 10:44:22 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
        by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3rv65xa11p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <stable@vger.kernel.org>; Mon, 17 Jul 2023 10:44:22 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
        by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 36HAiLwj5243620
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Jul 2023 10:44:21 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 374915805F;
        Mon, 17 Jul 2023 10:44:21 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EE8C758051;
        Mon, 17 Jul 2023 10:44:20 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
        by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 17 Jul 2023 10:44:20 +0000 (GMT)
MIME-Version: 1.0
Date:   Mon, 17 Jul 2023 12:44:20 +0200
From:   Harald Freudenberger <freude@linux.ibm.com>
To:     Holger Dengler <dengler@linux.ibm.com>
Cc:     linux390-list@tuxmaker.boeblingen.de.ibm.com,
        stable@vger.kernel.org
Subject: Re: [PATCH v2] s390/zcrypt: fix reply buffer calculations for CCA
 replies
Reply-To: freude@linux.ibm.com
Mail-Reply-To: freude@linux.ibm.com
In-Reply-To: <070fe3b0-5020-a74c-dd2d-22565f70d660@linux.ibm.com>
References: <20230714143630.457866-1-freude@linux.ibm.com>
 <070fe3b0-5020-a74c-dd2d-22565f70d660@linux.ibm.com>
Message-ID: <f79ade2bd5ec42b8016c1e62cfd9abec@linux.ibm.com>
X-Sender: freude@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: RxQW_nffdM6kfeKxjqERX38LJXQP_9OG
X-Proofpoint-GUID: RxQW_nffdM6kfeKxjqERX38LJXQP_9OG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-17_08,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501
 mlxlogscore=999 phishscore=0 malwarescore=0 clxscore=1015 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307170096
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 2023-07-17 10:45, Holger Dengler wrote:
> On 14/07/2023 16:36, Harald Freudenberger wrote:
>> The length information for available buffer space for CCA
>> replies is covered with two fields in the T6 header prepended
>> on each CCA reply: fromcardlen1 and fromcardlen2. The sum of
>> these both values must not exceed the AP bus limit for this
>> card (24KB for CEX8, 12KB CEX7 and older) minus the always
>> present headers.
>> 
>> The current code adjusted the fromcardlen2 value in case
>> of exceeding the AP bus limit when there was a non-zero
>> value given from userspace. Some tests now showed that this
>> was the wrong assumption. Instead the userspace value given for
>> this field should always be trusted and if the sum of the
>> wo fields exceeds the AP bus limit for this card the first
> 
> typo: two

fixed

> 
>> field fromcardlen1 should be adjusted instead.
>> 
>> So now the calculation is done with this new insight in mind.
>> Also some additional checks for overflow have been introduced
>> and some comments to provide some documentation for future
>> maintainers of this complicated calculation code.
>> 
>> Furthermore the 128 bytes of fix overhead which is used
>> in the current code is not correct. Investications showed
> 
> typo: Investigations

fixed ... did I forget to run the spell checker ??? ...

> 
>> that for a reply always the same two header structs are
>> prepended before a possible payload. So this is also fixed
>> with this patch.
>> 
>> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
>> Cc: stable@vger.kernel.org
> 
> With the typos fixed and the changes below
> Reviewed-by: Holger Dengler <dengler@linux.ibm.com>
> 
>> ---
>>  drivers/s390/crypto/zcrypt_msgtype6.c | 45 
>> ++++++++++++++++++++-------
>>  1 file changed, 33 insertions(+), 12 deletions(-)
>> 
>> diff --git a/drivers/s390/crypto/zcrypt_msgtype6.c 
>> b/drivers/s390/crypto/zcrypt_msgtype6.c
>> index 247f0ad38362..5ac110669327 100644
>> --- a/drivers/s390/crypto/zcrypt_msgtype6.c
>> +++ b/drivers/s390/crypto/zcrypt_msgtype6.c
>> @@ -551,6 +551,12 @@ static int xcrb_msg_to_type6_ep11cprb_msgx(bool 
>> userspace, struct ap_message *ap
>>   *
>>   * Returns 0 on success or -EINVAL, -EFAULT, -EAGAIN in case of an 
>> error.
>>   */
>> +struct type86_reply_hdrs {
>> +	struct type86_hdr hdr;
>> +	struct type86_fmt2_ext fmt2;
>> +	/* ... payload may follow ... */
>> +} __packed;
>> +
> 
> There is already a `struct type86_fmt2_msg` in this file (line 329 
> ff.).

Yes, I saw that. This will be consolidated with a cleanup patch series I 
am about
to develop just now.

> 
>>  struct type86x_reply {
>>  	struct type86_hdr hdr;
>>  	struct type86_fmt2_ext fmt2;
>> @@ -1101,23 +1107,38 @@ static long zcrypt_msgtype6_send_cprb(bool 
>> userspace, struct zcrypt_queue *zq,
>>  				      struct ica_xcRB *xcrb,
>>  				      struct ap_message *ap_msg)
>>  {
>> -	int rc;
>> +	unsigned int reply_bufsize_minus_headers =
>> +		zq->reply.bufsize - sizeof(struct type86_reply_hdrs);
> 
> I don't like this variable name. What about `max_payload_size`?
> 
>>  	struct response_type *rtype = ap_msg->private;
>>  	struct {
>>  		struct type6_hdr hdr;
>>  		struct CPRBX cprbx;
>>  		/* ... more data blocks ... */
>>  	} __packed * msg = ap_msg->msg;
>> -
>> -	/*
>> -	 * Set the queue's reply buffer length minus 128 byte padding
>> -	 * as reply limit for the card firmware.
>> -	 */
>> -	msg->hdr.fromcardlen1 = min_t(unsigned int, msg->hdr.fromcardlen1,
>> -				      zq->reply.bufsize - 128);
>> -	if (msg->hdr.fromcardlen2)
>> -		msg->hdr.fromcardlen2 =
>> -			zq->reply.bufsize - msg->hdr.fromcardlen1 - 128;
>> +	int rc, delta;
>> +
>> +	/* limit each of the two from fields to AP bus limit - headers */
> 
> I would also use "maximal payload size" here.
> /* limit each of the two from fields to the maximum payload size */

will do

> 
>> +	msg->hdr.fromcardlen1 = min_t(unsigned int,
>> +				      msg->hdr.fromcardlen1,
>> +				      reply_bufsize_minus_headers);
>> +	msg->hdr.fromcardlen2 = min_t(unsigned int,
>> +				      msg->hdr.fromcardlen2,
>> +				      reply_bufsize_minus_headers);
>> +
>> +	/* calculate delta if the sum of both exceeds AP bus limit - headers 
>> */
> 
> dito:
> /* calculate delta if the sum of both exceeds the maximum payload size 
> */
> 

jaaaa...

>> +	delta = msg->hdr.fromcardlen1 + msg->hdr.fromcardlen2
>> +		- reply_bufsize_minus_headers;
>> +	if (delta > 0) {
>> +		/*
>> +		 * Sum exceeds AP bus limit - headers, prune fromcardlen1
> 
> dito:
>  * Sum exceeds the maximum payload size, prune fromcardlen1
> 

ok

>> +		 * (always trust fromcardlen2)
>> +		 */
>> +		if (delta > msg->hdr.fromcardlen1) {
>> +			rc = -EINVAL;
>> +			goto out;
>> +		}
>> +		msg->hdr.fromcardlen1 -= delta;
>> +	}
>> 
>>  	init_completion(&rtype->work);
>>  	rc = ap_queue_message(zq->queue, ap_msg);
>> @@ -1240,7 +1261,7 @@ static long zcrypt_msgtype6_send_ep11_cprb(bool 
>> userspace, struct zcrypt_queue *
>>  	 * as reply limit for the card firmware.
>>  	 */
>>  	msg->hdr.fromcardlen1 = zq->reply.bufsize -
>> -		sizeof(struct type86_hdr) - sizeof(struct type86_fmt2_ext);
>> +		sizeof(struct type86_reply_hdrs);
>> 
>>  	init_completion(&rtype->work);
>>  	rc = ap_queue_message(zq->queue, ap_msg);
