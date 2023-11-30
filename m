Return-Path: <stable+bounces-3241-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14FE37FF21F
	for <lists+stable@lfdr.de>; Thu, 30 Nov 2023 15:36:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44FE51C20CDA
	for <lists+stable@lfdr.de>; Thu, 30 Nov 2023 14:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ED814879F;
	Thu, 30 Nov 2023 14:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Ignk9GyQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCD4693
	for <stable@vger.kernel.org>; Thu, 30 Nov 2023 06:36:18 -0800 (PST)
Received: by mail-il1-x12f.google.com with SMTP id e9e14a558f8ab-35ccfc5323aso109155ab.1
        for <stable@vger.kernel.org>; Thu, 30 Nov 2023 06:36:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1701354978; x=1701959778; darn=vger.kernel.org;
        h=in-reply-to:from:references:cc:to:content-language:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h7xIy8v/QxHdcjaI6UvJgQkJt5NPiA1mQV367JpQ7lE=;
        b=Ignk9GyQ+I3uwVTy58eY2aIM9fDexl1/Pv34s6zJYx29xati7xb/9M9z3VQhNYkMi1
         d5DRSPKjp89QZiQzDbszoVy4LhbajfMVVBCHF+BcsuF5vrlDfy8tyPCZ6zOChdILhSB1
         HQKJ7ADFvfODps/vKjE7nx5cVmNGl1WEQWbrhpBDUyxrXiztpaDyPFA+4wPguPynPEeS
         kIFTiTDNseCjzTbUe5eVAO149BNcjLaPpakazFz30UtPndv4hjQhw7Cu6niKufRo/eFT
         cFdFYIvAEMbU9CH3fkR9fdZoxw18pV7oNVc2mTuMfqoFiJSP985hfrVBOAS7UbgiwP7i
         X2xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701354978; x=1701959778;
        h=in-reply-to:from:references:cc:to:content-language:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=h7xIy8v/QxHdcjaI6UvJgQkJt5NPiA1mQV367JpQ7lE=;
        b=bFzEmIB2Rj3M5toNgv32jNnXZsXtQ6uhsruLaQbiZ3mQDOC6GGnt7eJIpAsYWO1Dm3
         KNY89cbdT/71U4P9sB/s+rOz0AH+Hstj//15nTygy0uI/amohRxNB9loaIf+O5ZY6g9c
         ZPe3xJ24ZQ7U7o1mpVEbWueEG+tYdDstcBk4Rubel2q3G8C9+hSjzYtB2rHAM945/EZz
         Igusu+1vCsn1ndmhBLc7WXh1LbfhLMkzUPdwGHjJluVswxXH4DoH/LfdQ41omI0rwsL5
         tfFXiSAEhr2P1dr9sXPivcNTMUVmVugSUW3qTIXO9jXY8Ifbg4UT5CRAiw0/+VrQuzMf
         loAw==
X-Gm-Message-State: AOJu0YzwkQOcy8H1mi3uJGzbrO13AoqzNDpkhD5ef4YrqjdZNoX4+W96
	bzaEXJDMtMPdHaarJuQtQN1shw==
X-Google-Smtp-Source: AGHT+IGd9XkI3lnJzGCDqCF4NsN1BOTSseQwdJdjpKPDLu9ffuLtH96PP8DmtUR1u9IOWr1PCDRWoA==
X-Received: by 2002:a6b:6915:0:b0:7b0:aea8:2643 with SMTP id e21-20020a6b6915000000b007b0aea82643mr2296304ioc.1.1701354978213;
        Thu, 30 Nov 2023 06:36:18 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id h4-20020a02c4c4000000b004664ecd1249sm316123jaj.106.2023.11.30.06.36.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Nov 2023 06:36:17 -0800 (PST)
Content-Type: multipart/mixed; boundary="------------aUi5VnYag08qDlSUsKGkbbIf"
Message-ID: <bc136dd7-9b65-4d10-8b0d-105c90246543@kernel.dk>
Date: Thu, 30 Nov 2023 07:36:17 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] io_uring: fix off-by one bvec index"
 failed to apply to 5.4-stable tree
Content-Language: en-US
To: gregkh@linuxfoundation.org, kbusch@kernel.org
Cc: stable@vger.kernel.org
References: <2023113025-eastbound-uninstall-c2e0@gregkh>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <2023113025-eastbound-uninstall-c2e0@gregkh>

This is a multi-part message in MIME format.
--------------aUi5VnYag08qDlSUsKGkbbIf
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/30/23 7:31 AM, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 5.4-stable tree.

And the 5.4 variant attached.

-- 
Jens Axboe


--------------aUi5VnYag08qDlSUsKGkbbIf
Content-Type: text/x-patch; charset=UTF-8;
 name="5.4-io_uring-fix-off-by-one-bvec-index.patch"
Content-Disposition: attachment;
 filename="5.4-io_uring-fix-off-by-one-bvec-index.patch"
Content-Transfer-Encoding: base64

RnJvbSBhYTRkZjFlZmE0NzI0MWY4YjlmYWFiOTNmOWQ3M2VkYTRhYTljY2YzIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBLZWl0aCBCdXNjaCA8a2J1c2NoQGtlcm5lbC5vcmc+
CkRhdGU6IE1vbiwgMjAgTm92IDIwMjMgMTQ6MTg6MzEgLTA4MDAKU3ViamVjdDogW1BBVENI
XSBpb191cmluZzogZml4IG9mZi1ieSBvbmUgYnZlYyBpbmRleAoKY29tbWl0IGQ2ZmVmMzRl
ZTRkMTAyYmU0NDgxNDZmMjRjYWY5NmQ3YjRhMDU0MDEgdXBzdHJlYW0uCgpJZiB0aGUgb2Zm
c2V0IGVxdWFscyB0aGUgYnZfbGVuIG9mIHRoZSBmaXJzdCByZWdpc3RlcmVkIGJ2ZWMsIHRo
ZW4gdGhlCnJlcXVlc3QgZG9lcyBub3QgaW5jbHVkZSBhbnkgb2YgdGhhdCBmaXJzdCBidmVj
LiBTa2lwIGl0IHNvIHRoYXQgZHJpdmVycwpkb24ndCBoYXZlIHRvIGRlYWwgd2l0aCBhIHpl
cm8gbGVuZ3RoIGJ2ZWMsIHdoaWNoIHdhcyBvYnNlcnZlZCB0byBicmVhawpOVk1lJ3MgUFJQ
IGxpc3QgY3JlYXRpb24uCgpDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZwpGaXhlczogYmQx
MWIzYTM5MWUzICgiaW9fdXJpbmc6IGRvbid0IHVzZSBpb3ZfaXRlcl9hZHZhbmNlKCkgZm9y
IGZpeGVkIGJ1ZmZlcnMiKQpTaWduZWQtb2ZmLWJ5OiBLZWl0aCBCdXNjaCA8a2J1c2NoQGtl
cm5lbC5vcmc+Ckxpbms6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3IvMjAyMzExMjAyMjE4
MzEuMjY0NjQ2MC0xLWtidXNjaEBtZXRhLmNvbQpTaWduZWQtb2ZmLWJ5OiBKZW5zIEF4Ym9l
IDxheGJvZUBrZXJuZWwuZGs+Ci0tLQogZnMvaW9fdXJpbmcuYyB8IDIgKy0KIDEgZmlsZSBj
aGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2Zz
L2lvX3VyaW5nLmMgYi9mcy9pb191cmluZy5jCmluZGV4IDM2ODNkZGViNjI1YS4uYWRjMjYz
NDAwNDcxIDEwMDY0NAotLS0gYS9mcy9pb191cmluZy5jCisrKyBiL2ZzL2lvX3VyaW5nLmMK
QEAgLTEyNTYsNyArMTI1Niw3IEBAIHN0YXRpYyBpbnQgaW9faW1wb3J0X2ZpeGVkKHN0cnVj
dCBpb19yaW5nX2N0eCAqY3R4LCBpbnQgcncsCiAJCSAqLwogCQljb25zdCBzdHJ1Y3QgYmlv
X3ZlYyAqYnZlYyA9IGltdS0+YnZlYzsKIAotCQlpZiAob2Zmc2V0IDw9IGJ2ZWMtPmJ2X2xl
bikgeworCQlpZiAob2Zmc2V0IDwgYnZlYy0+YnZfbGVuKSB7CiAJCQlpb3ZfaXRlcl9hZHZh
bmNlKGl0ZXIsIG9mZnNldCk7CiAJCX0gZWxzZSB7CiAJCQl1bnNpZ25lZCBsb25nIHNlZ19z
a2lwOwotLSAKMi40Mi4wCgo=

--------------aUi5VnYag08qDlSUsKGkbbIf--

