Return-Path: <stable+bounces-214746-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SE3WB0WOhmlTOwQAu9opvQ
	(envelope-from <stable+bounces-214746-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 07 Feb 2026 01:58:45 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 692FC104624
	for <lists+stable@lfdr.de>; Sat, 07 Feb 2026 01:58:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 91F443016ECB
	for <lists+stable@lfdr.de>; Sat,  7 Feb 2026 00:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1267A228CB8;
	Sat,  7 Feb 2026 00:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=0x83.eu header.i=@0x83.eu header.b="U4T64hqU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kitvJjB1"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8576042A82;
	Sat,  7 Feb 2026 00:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770425912; cv=none; b=uAeYtEOFSZgsQWQDwBd4ZtSTNCtAMUWtwQblG7LjVtovO4Ut1dPjbZaRLn9vnm104Q4jJy1VY3osJ5uU1peXF3qooQNWE/PzdjsAmPpJKzDDsvJ6Jsez+6LooMxRfU+hzCk9w03kFOVwz0EbEpmpmJHB9a40teqSSK0oI4elaqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770425912; c=relaxed/simple;
	bh=idyUjNqSPHil9Oxf4HZigKbjtgA06FLaMTDmxtNd8UQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jZbQ7k4IDuXeMnUNI45wiEjPRwSH1tw/FNd5IrQUJ3ovrmqxq5fMI583NIxaZtJnfnYqKoIw3NGWCwlt1nmhnvWsG+VjfTdxoetMdR80LxrMlkS23ZRFMXlEiuHWcVk2z9rIO40LLXRY4Y9pkUpBAtRl0sLjjzn4bYtjAx58Xqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=0x83.eu; spf=pass smtp.mailfrom=0x83.eu; dkim=pass (2048-bit key) header.d=0x83.eu header.i=@0x83.eu header.b=U4T64hqU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kitvJjB1; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=0x83.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0x83.eu
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B61571400086;
	Fri,  6 Feb 2026 19:58:31 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 06 Feb 2026 19:58:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0x83.eu; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1770425911;
	 x=1770512311; bh=fT3PN4MR6F5JuLBltfcWmJnH6oFaSBd63aB+l9JLo2E=; b=
	U4T64hqUK6+9INtSW3A2CCVoLRbzjFuvRHCZuJ3HZU1ngkymR8GQ2S6UvUeVhz9Z
	1IK6TrNWkNVILVUXWSQe8fRceUjEPZ1Z4J89Fy3MBfbcin8XQSVjXW7GHzOqtusa
	smRXbWbsQFrAF23VhvRkKpTVjTAkcmFcgte0hw3HWGTWAVshgpMlWNmOhHhAt+Zl
	Em8eJm03Ls0E1xqrqNZBBtOSR3eHHVFbRPg+d9qCFWzjQLCL7xkoV4Tv/Vz1oVDd
	4RN+/KyTlZFWW3nSSuhHRMNCbOYt03kgEy56LXr1LS2XhPfYBRyYhyNI7+HhARTG
	ejY2ZGxMsNLKC9Ii99E0Gw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770425911; x=
	1770512311; bh=fT3PN4MR6F5JuLBltfcWmJnH6oFaSBd63aB+l9JLo2E=; b=k
	itvJjB17/Wgb94rpqwRucW1zz/AtRRw3kn4HlqQkJ1wu75KpCPyWDWKaPQTdP8NX
	HgKImnm7clN31UKr2LyoZbYeNjdK9JKQpcuTTs5kp4qUA5J9FRKzs100SvycmMKk
	sY18YpeigNczOqXvm0UNqt+iLr+Hn7eRgYw7ZHGpXS3NDiIt5c1lxXQoNqRNVSHP
	lCAQ/g6kyRKLlSL9NAveW14SQVPPhtVSev03xeXPEiCNPOHE30n977c2NNDqs/v7
	c2ALSlOUAV83lBHHqV5/vo6H36OykihA3EpuY4xGz3hqFSXVUWDy+EagIyoXx5GA
	t835lZDDi8cMSpTUUmykw==
X-ME-Sender: <xms:N46GaR-za230c_efrWcDzFCCrFrfzJtuHK3e7LaRCB8spT6XM1W27w>
    <xme:N46GaRnxQVOPPeWEOZDUlICQaqY_2o3xoY668VinJUwn4scj4L8nNr0eM2O3Uumq3
    ho00AWBgP3THrvdi6VnEPNjyKci_Kwt2xaObAKpN02UIjmmMYg-eQ>
X-ME-Received: <xmr:N46GacA4h3KY68jzFY25TEGIbwPw_IBUYAtXtAAN9YS8ciAKQ9ERXU8F1LuK9ux2c4hT4R-wV--K9Gi6GVa55pGp>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukeelieejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpedfnfhukhgr
    shcumfdrfdcuoehluhestdigkeefrdgvuheqnecuggftrfgrthhtvghrnhephfehfefgge
    ekueevvefftdevheelgfekfeefiedtleektdffhfduueefueehfeeunecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheplhhusedtgiekfedrvghupd
    hnsggprhgtphhtthhopeduuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphgr
    sggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehmihgthhgrvghlrdhthhgrlh
    hmvghivghrsehhrghlvgdrrghtpdhrtghpthhtohepuggvvghprghkrdhshhgrrhhmrgdr
    geejvdelfeehsehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhhriihksehkvghrnhgvlh
    drohhrghdprhgtphhtthhopehvrgguihhmrdhfvgguohhrvghnkhhosehlihhnuhigrdgu
    vghvpdhrtghpthhtohephhhorhhmsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkh
    husggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrd
    hkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:N46GaaUUwc6F9o3Bb1GgAZfplRP1fEKycEZy-bV6_QiQnwqt0trOhg>
    <xmx:N46Gaa9BL2cwCx6gyuY8esUNR0wNQpn5kSxYXjKU2RzbnqaayCNGWA>
    <xmx:N46GacRuJOaRCBXZ6nb40ZRbugajYPXFDD_-2vBNroMEN-dC9dK--g>
    <xmx:N46GafTXQRSxZ5bB9LK3XlBZ3gpzv0FPcC7MxgvJ--tukQbDfAE36Q>
    <xmx:N46GaTuVzU09ZKGwRFESva65jC6D0DHJ6hhITNPSyltJ6IHsbIdhh5GC>
Feedback-ID: if34840d3:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Feb 2026 19:58:28 -0500 (EST)
Message-ID: <e9d63690-cdf4-41b7-98a1-6ebdf818fa11@0x83.eu>
Date: Sat, 7 Feb 2026 01:58:26 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v5] net: nfc: nci: Fix parameter validation for packet
 data
To: Paolo Abeni <pabeni@redhat.com>,
 Michael Thalmeier <michael.thalmeier@hale.at>,
 Deepak Sharma <deepak.sharma.472935@gmail.com>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, Simon Horman
 <horms@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 Michael Thalmeier <michael@thalmeier.at>, stable@vger.kernel.org
References: <20260112124819.171028-1-michael.thalmeier@hale.at>
 <21e77ec4-fa57-4a9f-8d9b-c417fd908ac6@redhat.com>
Content-Language: en-GB
From: "Lukas K." <lu@0x83.eu>
In-Reply-To: <21e77ec4-fa57-4a9f-8d9b-c417fd908ac6@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[0x83.eu,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[0x83.eu:s=fm1,messagingengine.com:s=fm3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[redhat.com,hale.at,gmail.com,kernel.org,linux.dev];
	TAGGED_FROM(0.00)[bounces-214746-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[0x83.eu:+,messagingengine.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lu@0x83.eu,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.979];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,0x83.eu:mid,0x83.eu:dkim,hale.at:email,messagingengine.com:dkim]
X-Rspamd-Queue-Id: 692FC104624
X-Rspamd-Action: no action



On 15.01.26 12:25, Paolo Abeni wrote:
> On 1/12/26 1:48 PM, Michael Thalmeier wrote:
>> Since commit 9c328f54741b ("net: nfc: nci: Add parameter validation for
>> packet data") communication with nci nfc chips is not working any more.
>>
>> The mentioned commit tries to fix access of uninitialized data, but
>> failed to understand that in some cases the data packet is of variable
>> length and can therefore not be compared to the maximum packet length
>> given by the sizeof(struct).
>>
>> Fixes: 9c328f54741b ("net: nfc: nci: Add parameter validation for packet data")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Michael Thalmeier <michael.thalmeier@hale.at>
> 
> AFAICS this patch is doing at least 2 separate things:
> 
> - what described above,
> - adding the missing checkes in
> nci_extract_rf_params_nfcf_passive_listen and nci_rf_discover_ntf_packet
> 
> the latter is completely not described above and should land in separate
> patch; note that whatever follows the '---' separator will not enter the
> changelog.
> 
>> @@ -138,23 +142,49 @@ static int nci_core_conn_intf_error_ntf_packet(struct nci_dev *ndev,
>>   static const __u8 *
>>   nci_extract_rf_params_nfca_passive_poll(struct nci_dev *ndev,
>>   					struct rf_tech_specific_params_nfca_poll *nfca_poll,
>> -					const __u8 *data)
>> +					const __u8 *data, size_t data_len)
>>   {
>> +	/* Check if we have enough data for sens_res (2 bytes) */
>> +	if (data_len < 2)
>> +		return ERR_PTR(-EINVAL);
>> +
>>   	nfca_poll->sens_res = __le16_to_cpu(*((__le16 *)data));
>>   	data += 2;
>> +	data_len -= 2;
>> +
>> +	/* Check if we have enough data for nfcid1_len (1 byte) */
>> +	if (data_len < 1)
>> +		return ERR_PTR(-EINVAL);
>>   
>>   	nfca_poll->nfcid1_len = min_t(__u8, *data++, NFC_NFCID1_MAXSIZE);
>> +	data_len--;
>>   
>>   	pr_debug("sens_res 0x%x, nfcid1_len %d\n",
>>   		 nfca_poll->sens_res, nfca_poll->nfcid1_len);
>>   
As far as I can tell, the code ensures that data_len never underflows. 
If that'd happen all subsequent length checks would pass, even though 
they should not. Using  a signed type (ssize_t?) would provide some 
extra safety in here.
>> +	/* Check if we have enough data for nfcid1 */
>> +	if (data_len < nfca_poll->nfcid1_len)
>> +		return ERR_PTR(-EINVAL);
>> +
>>   	memcpy(nfca_poll->nfcid1, data, nfca_poll->nfcid1_len);
>>   	data += nfca_poll->nfcid1_len;
>> +	data_len -= nfca_poll->nfcid1_len;
>> +
>> +	/* Check if we have enough data for sel_res_len (1 byte) */
>> +	if (data_len < 1)
>> +		return ERR_PTR(-EINVAL);
>>   
>>   	nfca_poll->sel_res_len = *data++;
>> +	data_len--;
>> +
>> +	if (nfca_poll->sel_res_len != 0) {
>> +		/* Check if we have enough data for sel_res (1 byte) */
>> +		if (data_len < 1)
>> +			return ERR_PTR(-EINVAL);
>>   
>> -	if (nfca_poll->sel_res_len != 0)
>>   		nfca_poll->sel_res = *data++;
>> +		data_len--;



