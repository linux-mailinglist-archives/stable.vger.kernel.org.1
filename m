Return-Path: <stable+bounces-237935-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YBnqBS933mkqEgAAu9opvQ
	(envelope-from <stable+bounces-237935-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 19:19:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E73E3FCFE0
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 19:19:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 30D07309D7A6
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 17:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F230A3E0C4E;
	Tue, 14 Apr 2026 17:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zb/wMZt2"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B237238F93D
	for <stable@vger.kernel.org>; Tue, 14 Apr 2026 17:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776186977; cv=none; b=JoJNnnUjvteqauUl2oXEaYCoG3K2fI+x8Bhf99sbb1pQgsKxQ/fwG5jtKYmXjkuQRl90+iGBbz9WoeCMbkP1iZLrMm+Xnqp9F+mvEUNBCLJCc9kDLLxp8PJyU3QkzpdyMRbb29g3/XAqrc5GJ5wxyloWpfboGQhQcIN0mAei/2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776186977; c=relaxed/simple;
	bh=a34u5VYi+HH6ZgXfKa2GQcL1piGR6fblTlJ80ZzRtvM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hq3Pmedi/1TYM2ejzY4z8iwOL47C/6ihcH05g0JnRrpPgnCBWxw9UO9JQPAL0n4MTftMUxNcNfsGYvxxbgWQq2V+BwlKxs5vbOn+Mugigm44VhUGCKRj8OEj/0DKCitdFXQ8AGYJIF20u5zZLJo7B+L7O14mTXo1N5bhs7yDxDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zb/wMZt2; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-2d868d014a5so2656143eec.1
        for <stable@vger.kernel.org>; Tue, 14 Apr 2026 10:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776186976; x=1776791776; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a34u5VYi+HH6ZgXfKa2GQcL1piGR6fblTlJ80ZzRtvM=;
        b=Zb/wMZt2XDvPyJ86T+7rRST0lFoil+TjYLnLrGtoF9GGcdUAJwuXrq4vo4azKaVnnK
         MDCn8q+79HrnlFfF7ngYQEfhzTW6O1BiA2WXuFJGrdVVzpt2FqeEIhEDNggnx2B73Vh5
         J16LAym67tMgZXdiLOFVRt5DTCVX80XVuPlA66QRddAhrFPEyhZXt6PfW1+ABmUEpOlx
         eymZ9K70DJ8/fn+/ryO6AHbirwWBMO/Za/gD7pCwAeUoTyhbogHEXtELy4lS87wrDU/4
         RfC6Z3Y5QKOQ3AOgSNLZmF8hg38iau2p6YPKJu6Ys6xgEuY6mEZycCyYE9+jtSHhIG9a
         3DwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776186976; x=1776791776;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a34u5VYi+HH6ZgXfKa2GQcL1piGR6fblTlJ80ZzRtvM=;
        b=OGz3gg2VWuk3ir5Go7u0EaDmsJZkVC/SkNXfIvutaTOIqa5XzRPcOQs8jw7xqULUaa
         BO2XYiS9WCX6vrWR99SFGi7M0HBIFjHVsQFVp9LkSmJEyFV67cHsM70FCGxx6CQgB8eg
         4QXHY9zA8xjUK6zTcAAJZsLpjKLfD+CIgslS3ETbjHrnaoVDccPw+sUixU5N4Iciydtd
         g6M59zBVmKSDLR/VwYw5vKtsncymtnnk+QJCTKA06u2GIaa8ariSQJ5ZUPt/PcFJEIEl
         kuurxUhutmxmOFJUpE2oIRNmajn8kh28LWhay2sO4RPjCTf5iTtPL29TBOtciIbnp9B2
         tnZw==
X-Gm-Message-State: AOJu0YwA/pf4RXrau85mHEzkKsrF978zZQbv0ulkiHb9FO1el0uLQAWn
	GAhbi/cvskk9dxVp8asRfhQV0cVLHES9BYWPyKwqMHWp7IvsVJb+9HZ4
X-Gm-Gg: AeBDieudjokEO7NcFpFuu6BSFaTdy/Jhv/b/B296dnnyfRShoriPfQrTJmvY9GfzVkK
	QcataS8YBqIdGezIXsHVYiRGMdZANe0hr3K97iTz6My5kQWsQo+XwPF+irx6Krz2qa68+GijbBb
	4WzNUVja9Lpd44sC4lvYVcG0W1GxiTIXSBfb05nZDYblbK/v4WXsMfVg4LpVgFco89MbMVI4Byp
	ecHz7NCdqHUZkOQFeBQ0TFbrwoNX2HFDseU3r2e2GJYAMWfxFXySyi9BPCZpHYsTZNAdOoOyAHq
	AOHsdR6j3a3UuVe9m5DA2CeGveS0K9uRpiNkFNODEist2kHgQWK6z+iI0+o9/Y9Bv08dWJtttSa
	EJZUhjkElhvxx5rX2YDSHTkwrVE/g/2OwDy6dWi25PEaPjfEHEhOWzjfBC7uUpJsd9bGv2m2SK4
	bb4vvUhcXy7fYIZg7R2szpS6LL
X-Received: by 2002:a05:7300:7313:b0:2d8:b2e1:20cf with SMTP id 5a478bee46e88-2d8b2e122fbmr5869059eec.10.1776186975660;
        Tue, 14 Apr 2026 10:16:15 -0700 (PDT)
Received: from ?IPV6:2600:6c5c:6b00:ba4::23? ([2600:6c5c:6b00:ba4::23])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d80acca4c5sm17167382eec.19.2026.04.14.10.16.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Apr 2026 10:16:15 -0700 (PDT)
Message-ID: <950488da-4776-44cf-8756-ecb717de5d38@gmail.com>
Date: Tue, 14 Apr 2026 13:16:13 -0400
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v2] e1000e: Unroll PTP in probe
 error handling
To: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>,
 intel-wired-lan@osuosl.org
Cc: stable@vger.kernel.org, Avigail Dahan <avigailx.dahan@intel.com>
References: <20260413000325.33379-1-tactii@gmail.com>
 <01cee873-23d7-43f5-96eb-29826d1c157c@linux.intel.com>
Content-Language: en-US
From: Matt Vollrath <tactii@gmail.com>
In-Reply-To: <01cee873-23d7-43f5-96eb-29826d1c157c@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-237935-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tactii@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3E73E3FCFE0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/14/26 04:55, Dawid Osuchowski wrote:
> Apologies but it seems I didn't explain fully where the changelog should go, same goes for the Cc: stable as it should be inserted into the commit msg as a tag, see example below.

Thanks Dawid, I had figured out the changelog after sending this by looking at other patches, but didn't see anyone else adding the Cc tag.
mv


