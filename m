Return-Path: <stable+bounces-216044-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6OArC33+jmmOGwEAu9opvQ
	(envelope-from <stable+bounces-216044-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 11:35:41 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E858135213
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 11:35:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E56CE304BCD0
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 10:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AC1D34F481;
	Fri, 13 Feb 2026 10:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="EghF1Qbr"
X-Original-To: stable@vger.kernel.org
Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.63.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53028335543;
	Fri, 13 Feb 2026 10:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.68.63.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770978917; cv=none; b=LJOXk5i1qM5LG5Td/qeHrDdE2hSOF+hZIBtKD3jc4Gkbkkp8YsybbQGTpBLt4kcOTkYO0FYgTD6BiMEH50oLCNUl57W0x47GxR8FY4RqbT1fjyEfhE5tktzzmVuddHyA9Z7/+xMbeE1L4jAEI4YZiPVXCmdCkIN2olSh3A4FEc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770978917; c=relaxed/simple;
	bh=ydGOxu/DDZ5vk3wWhJm3tP6qQ8UGgOOESrYzqnkTI5g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IpEDeJzeDfv0ntJU074jKaIi8ztoSWNQIYGi7ePXv3C6kGERUueFqf4gqgaj0R3TEXE+7USZujnjbt93z/Fvn3ruZza0BqUmOWnV3lpIueROvIA0YbEaIg/gmUTK3j7xXScs6gdBKudBRALHBp+YQ6EjFnez7OyLF8uVBQHaZSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=EghF1Qbr; arc=none smtp.client-ip=188.68.63.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Received: from mors-relay-8202.netcup.net (localhost [127.0.0.1])
	by mors-relay-8202.netcup.net (Postfix) with ESMTPS id 4fC7pg6y20z41PJ;
	Fri, 13 Feb 2026 11:35:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1770978908;
	bh=ydGOxu/DDZ5vk3wWhJm3tP6qQ8UGgOOESrYzqnkTI5g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=EghF1QbrrqCAX60qpK+SNdqslB8LJmF1+gkASayzGcwcmSa+KiU/XwelUtGrJsLSY
	 wwEJQsfRlFbrYutUMG/Y0rYFUzay+FoFsm5LdAZrWYIqxCt+eLaf5a0VaQfdcrPWxn
	 +MMofbfspQP1jq4bkX7JZayJC+ZF3/8Vyf167rG1JjXuuLwSXA3RzQxIWB6O5CZC+d
	 zP3h3rXzYfs2PoDk0dckA5MnvgL3q0Yw6tq/WO/0tqKwFutptrYhlu9+WuwMdMrF8B
	 2AvRa17VM1grMma0EpHKOAUCwG0KmMO1/hJB0+8S0bkQihcCkBDbM8yklaKV6oF2nL
	 6F2RLVuhofDYA==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-8202.netcup.net (Postfix) with ESMTPS id 4fC7pg6Bd9z415J;
	Fri, 13 Feb 2026 11:35:07 +0100 (CET)
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4fC7pg1RFNz8svL;
	Fri, 13 Feb 2026 11:35:07 +0100 (CET)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id 400EA67258;
	Fri, 13 Feb 2026 11:35:06 +0100 (CET)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <9383904a-81b1-492b-945d-a47fd065c727@leemhuis.info>
Date: Fri, 13 Feb 2026 11:35:00 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v5] net: nfc: nci: Fix parameter validation for packet
 data
To: "Lukas K." <lu@0x83.eu>, Paolo Abeni <pabeni@redhat.com>,
 Michael Thalmeier <michael.thalmeier@hale.at>,
 Deepak Sharma <deepak.sharma.472935@gmail.com>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, Simon Horman
 <horms@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Linux kernel regressions list <regressions@lists.linux.dev>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 Michael Thalmeier <michael@thalmeier.at>, stable@vger.kernel.org
References: <20260112124819.171028-1-michael.thalmeier@hale.at>
 <21e77ec4-fa57-4a9f-8d9b-c417fd908ac6@redhat.com>
 <e9d63690-cdf4-41b7-98a1-6ebdf818fa11@0x83.eu>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
X-Enigmail-Draft-Status: N11222
Autocrypt: addr=linux@leemhuis.info; keydata=
 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 MEK4
In-Reply-To: <e9d63690-cdf4-41b7-98a1-6ebdf818fa11@0x83.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <177097890671.1065606.94545132246866571@mxe9fb.netcup.net>
X-NC-CID: DBC9/OsMnyEm+UUi6TK/TcORKENNy+lxtGnytvOzKKwZUsT02YI=
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[leemhuis.info:s=key2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[leemhuis.info];
	FREEMAIL_TO(0.00)[0x83.eu,redhat.com,hale.at,gmail.com,kernel.org,linux.dev,lists.linux.dev];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-216044-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[regressions@leemhuis.info,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[leemhuis.info:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 7E858135213
X-Rspamd-Action: no action

On 2/7/26 01:58, Lukas K. wrote:
> On 15.01.26 12:25, Paolo Abeni wrote:
>> On 1/12/26 1:48 PM, Michael Thalmeier wrote:
>>> Since commit 9c328f54741b ("net: nfc: nci: Add parameter validation for
>>> packet data") communication with nci nfc chips is not working any more.
>>>
>>> The mentioned commit tries to fix access of uninitialized data, but
>>> failed to understand that in some cases the data packet is of variable
>>> length and can therefore not be compared to the maximum packet length
>>> given by the sizeof(struct).
>>>
>>> Fixes: 9c328f54741b ("net: nfc: nci: Add parameter validation for
>>> packet data")
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Michael Thalmeier <michael.thalmeier@hale.at>
>>
>> AFAICS this patch is doing at least 2 separate things:
>>
>> - what described above,
>> - adding the missing checkes in
>> nci_extract_rf_params_nfcf_passive_listen and nci_rf_discover_ntf_packet
>>
>> the latter is completely not described above and should land in separate
>> patch; note that whatever follows the '---' separator will not enter the
>> changelog.

Please correct me if I'm wrong, but seems things are stalled here and
there is no fix for the regression in sight that is know since
2025-12-09:
https://lore.kernel.org/all/20251209132103.3736761-1-michael.thalmeier@hale.at/

I might be missing something, but if not I guess it's best if we revert
the culprit quickly, given these factors:
* We are way past the "[fix regressions] within a week, preferably
before the next rc." that Linus would like to see:
https://lore.kernel.org/all/CAHk-%3Dwi86AosXs66-yi54%2BmpQjPu0upxB8ZAfG%2BLsMyJmcuMSA@mail.gmail.com/
* Lukas running into and reporting same problem recently – and
confirming that a revert helps:
https://lore.kernel.org/all/11b7567e-b9a4-4546-9b1c-bb9820bead0c@0x83.eu/
* The culprit was backported to various stable/longterm kernels.

Or has anyone a better idea?

Ciao, Thorsten

>>> @@ -138,23 +142,49 @@ static int
>>> nci_core_conn_intf_error_ntf_packet(struct nci_dev *ndev,
>>>   static const __u8 *
>>>   nci_extract_rf_params_nfca_passive_poll(struct nci_dev *ndev,
>>>                       struct rf_tech_specific_params_nfca_poll
>>> *nfca_poll,
>>> -                    const __u8 *data)
>>> +                    const __u8 *data, size_t data_len)
>>>   {
>>> +    /* Check if we have enough data for sens_res (2 bytes) */
>>> +    if (data_len < 2)
>>> +        return ERR_PTR(-EINVAL);
>>> +
>>>       nfca_poll->sens_res = __le16_to_cpu(*((__le16 *)data));
>>>       data += 2;
>>> +    data_len -= 2;
>>> +
>>> +    /* Check if we have enough data for nfcid1_len (1 byte) */
>>> +    if (data_len < 1)
>>> +        return ERR_PTR(-EINVAL);
>>>         nfca_poll->nfcid1_len = min_t(__u8, *data++,
>>> NFC_NFCID1_MAXSIZE);
>>> +    data_len--;
>>>         pr_debug("sens_res 0x%x, nfcid1_len %d\n",
>>>            nfca_poll->sens_res, nfca_poll->nfcid1_len);
>>>   
> As far as I can tell, the code ensures that data_len never underflows.
> If that'd happen all subsequent length checks would pass, even though
> they should not. Using  a signed type (ssize_t?) would provide some
> extra safety in here.
>>> +    /* Check if we have enough data for nfcid1 */
>>> +    if (data_len < nfca_poll->nfcid1_len)
>>> +        return ERR_PTR(-EINVAL);
>>> +
>>>       memcpy(nfca_poll->nfcid1, data, nfca_poll->nfcid1_len);
>>>       data += nfca_poll->nfcid1_len;
>>> +    data_len -= nfca_poll->nfcid1_len;
>>> +
>>> +    /* Check if we have enough data for sel_res_len (1 byte) */
>>> +    if (data_len < 1)
>>> +        return ERR_PTR(-EINVAL);
>>>         nfca_poll->sel_res_len = *data++;
>>> +    data_len--;
>>> +
>>> +    if (nfca_poll->sel_res_len != 0) {
>>> +        /* Check if we have enough data for sel_res (1 byte) */
>>> +        if (data_len < 1)
>>> +            return ERR_PTR(-EINVAL);
>>>   -    if (nfca_poll->sel_res_len != 0)
>>>           nfca_poll->sel_res = *data++;
>>> +        data_len--;
> 
> 
> 


