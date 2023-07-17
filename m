Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 729DD755EB2
	for <lists+stable@lfdr.de>; Mon, 17 Jul 2023 10:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbjGQIp5 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 17 Jul 2023 04:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjGQIp4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 17 Jul 2023 04:45:56 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEF841A2
        for <stable@vger.kernel.org>; Mon, 17 Jul 2023 01:45:55 -0700 (PDT)
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36H8g8sv009122
        for <stable@vger.kernel.org>; Mon, 17 Jul 2023 08:45:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=RycMdtM6YbAFvCzWlvMA5391al2hERkhrZEV24Qps+0=;
 b=spyMb9Kevj3STLhNJ0f44J4izManGCRoObt/taNRUV/Es/XbB+Ex23p++wZmJ5940B0p
 rKkGNbKm/Z7Gk83Yi569LZC23LaO0u6cOqeSHIf2SgmgpXtvGeBub4p2DSNZ3phR30Kn
 Idov2ulpdg2YnDs3CdCwq56Zwr3RV8uXYyB3UELd7+cBwhasxxNAs/TxzcP4VJ721t4W
 HCOJ9LerFsMRnuPaLoVlcpxKH37ppAAU6kvTx/W7dYWo/hpkC/iD7yh/b9ZwNONIdtSL
 yH+hUfIVYhveFzuDvWB7pw7QZws2+jsI4p/NtykGU4J54kZ6MprgcB5EwaNjkJ8fO2FV 3A== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rw1krs6jk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <stable@vger.kernel.org>; Mon, 17 Jul 2023 08:45:54 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 36H1sIpD027431
        for <stable@vger.kernel.org>; Mon, 17 Jul 2023 08:45:52 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma05fra.de.ibm.com (PPS) with ESMTPS id 3ruk350uj1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <stable@vger.kernel.org>; Mon, 17 Jul 2023 08:45:52 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 36H8jnX323200292
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Jul 2023 08:45:49 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2CF292004B;
        Mon, 17 Jul 2023 08:45:49 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E454E20040;
        Mon, 17 Jul 2023 08:45:48 +0000 (GMT)
Received: from [9.171.84.213] (unknown [9.171.84.213])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 17 Jul 2023 08:45:48 +0000 (GMT)
Message-ID: <070fe3b0-5020-a74c-dd2d-22565f70d660@linux.ibm.com>
Date:   Mon, 17 Jul 2023 10:45:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] s390/zcrypt: fix reply buffer calculations for CCA
 replies
Content-Language: en-US
To:     Harald Freudenberger <freude@linux.ibm.com>,
        linux390-list@tuxmaker.boeblingen.de.ibm.com
Cc:     stable@vger.kernel.org
References: <20230714143630.457866-1-freude@linux.ibm.com>
From:   Holger Dengler <dengler@linux.ibm.com>
In-Reply-To: <20230714143630.457866-1-freude@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: UD6ZBBzx6CKhLTi97KmZk392hyXP-0gX
X-Proofpoint-GUID: UD6ZBBzx6CKhLTi97KmZk392hyXP-0gX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-17_07,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 clxscore=1011 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307170077
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 14/07/2023 16:36, Harald Freudenberger wrote:
> The length information for available buffer space for CCA
> replies is covered with two fields in the T6 header prepended
> on each CCA reply: fromcardlen1 and fromcardlen2. The sum of
> these both values must not exceed the AP bus limit for this
> card (24KB for CEX8, 12KB CEX7 and older) minus the always
> present headers.
> 
> The current code adjusted the fromcardlen2 value in case
> of exceeding the AP bus limit when there was a non-zero
> value given from userspace. Some tests now showed that this
> was the wrong assumption. Instead the userspace value given for
> this field should always be trusted and if the sum of the
> wo fields exceeds the AP bus limit for this card the first

typo: two

> field fromcardlen1 should be adjusted instead.
> 
> So now the calculation is done with this new insight in mind.
> Also some additional checks for overflow have been introduced
> and some comments to provide some documentation for future
> maintainers of this complicated calculation code.
> 
> Furthermore the 128 bytes of fix overhead which is used
> in the current code is not correct. Investications showed

typo: Investigations

> that for a reply always the same two header structs are
> prepended before a possible payload. So this is also fixed
> with this patch.
> 
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
> Cc: stable@vger.kernel.org

With the typos fixed and the changes below
Reviewed-by: Holger Dengler <dengler@linux.ibm.com>

> ---
>  drivers/s390/crypto/zcrypt_msgtype6.c | 45 ++++++++++++++++++++-------
>  1 file changed, 33 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/s390/crypto/zcrypt_msgtype6.c b/drivers/s390/crypto/zcrypt_msgtype6.c
> index 247f0ad38362..5ac110669327 100644
> --- a/drivers/s390/crypto/zcrypt_msgtype6.c
> +++ b/drivers/s390/crypto/zcrypt_msgtype6.c
> @@ -551,6 +551,12 @@ static int xcrb_msg_to_type6_ep11cprb_msgx(bool userspace, struct ap_message *ap
>   *
>   * Returns 0 on success or -EINVAL, -EFAULT, -EAGAIN in case of an error.
>   */
> +struct type86_reply_hdrs {
> +	struct type86_hdr hdr;
> +	struct type86_fmt2_ext fmt2;
> +	/* ... payload may follow ... */
> +} __packed;
> +

There is already a `struct type86_fmt2_msg` in this file (line 329 ff.).

>  struct type86x_reply {
>  	struct type86_hdr hdr;
>  	struct type86_fmt2_ext fmt2;
> @@ -1101,23 +1107,38 @@ static long zcrypt_msgtype6_send_cprb(bool userspace, struct zcrypt_queue *zq,
>  				      struct ica_xcRB *xcrb,
>  				      struct ap_message *ap_msg)
>  {
> -	int rc;
> +	unsigned int reply_bufsize_minus_headers =
> +		zq->reply.bufsize - sizeof(struct type86_reply_hdrs);

I don't like this variable name. What about `max_payload_size`?

>  	struct response_type *rtype = ap_msg->private;
>  	struct {
>  		struct type6_hdr hdr;
>  		struct CPRBX cprbx;
>  		/* ... more data blocks ... */
>  	} __packed * msg = ap_msg->msg;
> -
> -	/*
> -	 * Set the queue's reply buffer length minus 128 byte padding
> -	 * as reply limit for the card firmware.
> -	 */
> -	msg->hdr.fromcardlen1 = min_t(unsigned int, msg->hdr.fromcardlen1,
> -				      zq->reply.bufsize - 128);
> -	if (msg->hdr.fromcardlen2)
> -		msg->hdr.fromcardlen2 =
> -			zq->reply.bufsize - msg->hdr.fromcardlen1 - 128;
> +	int rc, delta;
> +
> +	/* limit each of the two from fields to AP bus limit - headers */

I would also use "maximal payload size" here.
/* limit each of the two from fields to the maximum payload size */

> +	msg->hdr.fromcardlen1 = min_t(unsigned int,
> +				      msg->hdr.fromcardlen1,
> +				      reply_bufsize_minus_headers);
> +	msg->hdr.fromcardlen2 = min_t(unsigned int,
> +				      msg->hdr.fromcardlen2,
> +				      reply_bufsize_minus_headers);
> +
> +	/* calculate delta if the sum of both exceeds AP bus limit - headers */

dito:
/* calculate delta if the sum of both exceeds the maximum payload size */

> +	delta = msg->hdr.fromcardlen1 + msg->hdr.fromcardlen2
> +		- reply_bufsize_minus_headers;
> +	if (delta > 0) {
> +		/*
> +		 * Sum exceeds AP bus limit - headers, prune fromcardlen1

dito:
 * Sum exceeds the maximum payload size, prune fromcardlen1

> +		 * (always trust fromcardlen2)
> +		 */
> +		if (delta > msg->hdr.fromcardlen1) {
> +			rc = -EINVAL;
> +			goto out;
> +		}
> +		msg->hdr.fromcardlen1 -= delta;
> +	}
>  
>  	init_completion(&rtype->work);
>  	rc = ap_queue_message(zq->queue, ap_msg);
> @@ -1240,7 +1261,7 @@ static long zcrypt_msgtype6_send_ep11_cprb(bool userspace, struct zcrypt_queue *
>  	 * as reply limit for the card firmware.
>  	 */
>  	msg->hdr.fromcardlen1 = zq->reply.bufsize -
> -		sizeof(struct type86_hdr) - sizeof(struct type86_fmt2_ext);
> +		sizeof(struct type86_reply_hdrs);
>  
>  	init_completion(&rtype->work);
>  	rc = ap_queue_message(zq->queue, ap_msg);

-- 
Mit freundlichen Grüßen / Kind regards
Holger Dengler
--
IBM Systems, Linux on IBM Z Development
dengler@linux.ibm.com
