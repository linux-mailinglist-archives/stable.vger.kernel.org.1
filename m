Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59C7377A019
	for <lists+stable@lfdr.de>; Sat, 12 Aug 2023 15:19:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbjHLNTt (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 12 Aug 2023 09:19:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjHLNTs (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 12 Aug 2023 09:19:48 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2D3C12D
        for <stable@vger.kernel.org>; Sat, 12 Aug 2023 06:19:51 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-686f74a8992so497095b3a.1
        for <stable@vger.kernel.org>; Sat, 12 Aug 2023 06:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1691846391; x=1692451191;
        h=in-reply-to:from:references:cc:to:content-language:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aM5mcsXqsctLvaE/N9KP4RvRX5M/M3vXBLntDOR6Jks=;
        b=nJMS1rzI0Kbi1nWFDb/UGW0XMBzX6ouBw3QA4SNAvJo/0HNCnU8a2lL+ONEXaSrLdX
         s3SKqPj2mwxWjf8VdxXvS1xznp4ucMRddy588hhyOaMmmd7NNEyrXs+/1QxGJeEHAE2E
         +U3ras0EgQHAyBU5RLk5OuWimQIBPrx3ivfAThpYJmlvcc6MofV4FNCRwKkAtZU106b3
         Be4OYPc24qK35dxd0WmLrreb2KRviXD6a/lliNLmZhcw4IDl+8LPRQEtynkpvCHUg4DZ
         +rqZF9t7gwxUJxv77yYt7OQ48cHmcLL6Um5JYWZpSu9cO3DN5EG2Mmp2vAe/abdNymqP
         l6KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691846391; x=1692451191;
        h=in-reply-to:from:references:cc:to:content-language:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aM5mcsXqsctLvaE/N9KP4RvRX5M/M3vXBLntDOR6Jks=;
        b=UwJlme/p/5tOyPztk+8i8oOgvw8CHYL8LWFTzFtocq8MT5jVHy7wOBHOtJbipr4DmU
         4o8/ko3oqJ732EhvaiXVIHHPX7ZHB6zhMqDbBbzGAyCho5QANPM4kqwdiqMDLc+xIJbY
         VY6+6M5bDRYs0NqF0INxjhsyJCh1XWyzSWLklkrSXcxt/3Kl1PHkTBRgGoIdDpv1yK8V
         PBrcRUQqiKLS69bni44t8X5NjuImzVt5DYBAGtTyksPk4p3MDPZN9Xw4g/EIxppIJ5Rg
         PMGQ393HdKAat15ahzXT7dPB1AFj6ogQWiEQPYjPUE5T2cgxNQb+6i6uAkvrtqjp0kmv
         Lw7A==
X-Gm-Message-State: AOJu0YykuEg903sIsSBhM+GFa+scz7+5vvB/Frav7xX6wbt52YsEFRjz
        cZVi90/nP1cq45hB6kJxIiadlRXZuFFBqycUK2g=
X-Google-Smtp-Source: AGHT+IHtYdgdQyB8eK1TFAOxkLEeDR1Oq5fqgubLmtUl0DbkZ49HW4Mi+zBqg62F0qm8mT93mujW6g==
X-Received: by 2002:a05:6a00:4986:b0:67d:308b:97ef with SMTP id dn6-20020a056a00498600b0067d308b97efmr5736662pfb.2.1691846390550;
        Sat, 12 Aug 2023 06:19:50 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id fe23-20020a056a002f1700b0067b643b814csm4899983pfb.6.2023.08.12.06.19.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Aug 2023 06:19:49 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------nrj0PqukOkPvZlnor6N6HtTB"
Message-ID: <df902d29-a183-4239-887b-4bdb62e8c1f0@kernel.dk>
Date:   Sat, 12 Aug 2023 07:19:48 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] io_uring: correct check for O_TMPFILE"
 failed to apply to 6.1-stable tree
Content-Language: en-US
To:     gregkh@linuxfoundation.org, cyphar@cyphar.com
Cc:     stable@vger.kernel.org
References: <2023081257-upcountry-punch-e196@gregkh>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <2023081257-upcountry-punch-e196@gregkh>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

This is a multi-part message in MIME format.
--------------nrj0PqukOkPvZlnor6N6HtTB
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/12/23 12:02 AM, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 6.1-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
> 
> To reproduce the conflict and resubmit, you may use the following commands:
> 
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
> git checkout FETCH_HEAD
> git cherry-pick -x 72dbde0f2afbe4af8e8595a89c650ae6b9d9c36f
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023081257-upcountry-punch-e196@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Here's one for 6.1-stable.

-- 
Jens Axboe


--------------nrj0PqukOkPvZlnor6N6HtTB
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-io_uring-correct-check-for-O_TMPFILE.patch"
Content-Disposition: attachment;
 filename="0001-io_uring-correct-check-for-O_TMPFILE.patch"
Content-Transfer-Encoding: base64

RnJvbSBiNzk0OTZlMTUzZWIwMjBmOTUxNTE5NzYyODQ0MjZiMDUwYTc5ZTk3IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBBbGVrc2EgU2FyYWkgPGN5cGhhckBjeXBoYXIuY29t
PgpEYXRlOiBTYXQsIDEyIEF1ZyAyMDIzIDA3OjE2OjExIC0wNjAwClN1YmplY3Q6IFtQQVRD
SF0gaW9fdXJpbmc6IGNvcnJlY3QgY2hlY2sgZm9yIE9fVE1QRklMRQoKQ29tbWl0IDcyZGJk
ZTBmMmFmYmU0YWY4ZTg1OTVhODljNjUwYWU2YjlkOWMzNmYgdXBzdHJlYW0uCgpPX1RNUEZJ
TEUgaXMgYWN0dWFsbHkgX19PX1RNUEZJTEV8T19ESVJFQ1RPUlkuIFRoaXMgbWVhbnMgdGhh
dCB0aGUgb2xkCmNoZWNrIGZvciB3aGV0aGVyIFJFU09MVkVfQ0FDSEVEIGNhbiBiZSB1c2Vk
IHdvdWxkIGluY29ycmVjdGx5IHRoaW5rCnRoYXQgT19ESVJFQ1RPUlkgY291bGQgbm90IGJl
IHVzZWQgd2l0aCBSRVNPTFZFX0NBQ0hFRC4KCkNjOiBzdGFibGVAdmdlci5rZXJuZWwub3Jn
ICMgdjUuMTIrCkZpeGVzOiAzYTgxZmQwMjA0NWMgKCJpb191cmluZzogZW5hYmxlIExPT0tV
UF9DQUNIRUQgcGF0aCByZXNvbHV0aW9uIGZvciBmaWxlbmFtZSBsb29rdXBzIikKU2lnbmVk
LW9mZi1ieTogQWxla3NhIFNhcmFpIDxjeXBoYXJAY3lwaGFyLmNvbT4KTGluazogaHR0cHM6
Ly9sb3JlLmtlcm5lbC5vcmcvci8yMDIzMDgwNy1yZXNvbHZlX2NhY2hlZC1vX3RtcGZpbGUt
djMtMS1lNDkzMjNlMWVmNmZAY3lwaGFyLmNvbQpTaWduZWQtb2ZmLWJ5OiBKZW5zIEF4Ym9l
IDxheGJvZUBrZXJuZWwuZGs+Ci0tLQogaW9fdXJpbmcvb3BlbmNsb3NlLmMgfCA2ICsrKyst
LQogMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRp
ZmYgLS1naXQgYS9pb191cmluZy9vcGVuY2xvc2UuYyBiL2lvX3VyaW5nL29wZW5jbG9zZS5j
CmluZGV4IDY3MTc4ZTRiYjI4Mi4uMDA4OTkwZTU4MTgwIDEwMDY0NAotLS0gYS9pb191cmlu
Zy9vcGVuY2xvc2UuYworKysgYi9pb191cmluZy9vcGVuY2xvc2UuYwpAQCAtMTEwLDkgKzEx
MCwxMSBAQCBpbnQgaW9fb3BlbmF0MihzdHJ1Y3QgaW9fa2lvY2IgKnJlcSwgdW5zaWduZWQg
aW50IGlzc3VlX2ZsYWdzKQogCWlmIChpc3N1ZV9mbGFncyAmIElPX1VSSU5HX0ZfTk9OQkxP
Q0spIHsKIAkJLyoKIAkJICogRG9uJ3QgYm90aGVyIHRyeWluZyBmb3IgT19UUlVOQywgT19D
UkVBVCwgb3IgT19UTVBGSUxFIG9wZW4sCi0JCSAqIGl0J2xsIGFsd2F5cyAtRUFHQUlOCisJ
CSAqIGl0J2xsIGFsd2F5cyAtRUFHQUlOLiBOb3RlIHRoYXQgd2UgdGVzdCBmb3IgX19PX1RN
UEZJTEUKKwkJICogYmVjYXVzZSBPX1RNUEZJTEUgaW5jbHVkZXMgT19ESVJFQ1RPUlksIHdo
aWNoIGlzbid0IGEgZmxhZworCQkgKiB3ZSBuZWVkIHRvIGZvcmNlIGFzeW5jIGZvci4KIAkJ
ICovCi0JCWlmIChvcGVuLT5ob3cuZmxhZ3MgJiAoT19UUlVOQyB8IE9fQ1JFQVQgfCBPX1RN
UEZJTEUpKQorCQlpZiAob3Blbi0+aG93LmZsYWdzICYgKE9fVFJVTkMgfCBPX0NSRUFUIHwg
X19PX1RNUEZJTEUpKQogCQkJcmV0dXJuIC1FQUdBSU47CiAJCW9wLmxvb2t1cF9mbGFncyB8
PSBMT09LVVBfQ0FDSEVEOwogCQlvcC5vcGVuX2ZsYWcgfD0gT19OT05CTE9DSzsKLS0gCjIu
NDAuMQoK

--------------nrj0PqukOkPvZlnor6N6HtTB--
