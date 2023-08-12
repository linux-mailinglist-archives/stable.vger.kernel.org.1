Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CE7F77A01A
	for <lists+stable@lfdr.de>; Sat, 12 Aug 2023 15:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbjHLNUR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 12 Aug 2023 09:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjHLNUR (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 12 Aug 2023 09:20:17 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76BEC12D
        for <stable@vger.kernel.org>; Sat, 12 Aug 2023 06:20:20 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-68781a69befso496748b3a.0
        for <stable@vger.kernel.org>; Sat, 12 Aug 2023 06:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1691846420; x=1692451220;
        h=in-reply-to:from:references:cc:to:content-language:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EDc7FGjt9vfCAeRrYiucDZbfHTjKkmO7dLH7SMdwKVw=;
        b=RGPsPke6EpL5595L+Jq9z17JysZZWU1Z1/27g5WjlUnbidOaFZbxlkkEwCjsRoZMYJ
         Ij6jtq0VqHgxThNa+6xjpbwqclQh96P7TWA/K2mbHAkFMxXL+b8eYiZNDneAkTWJlaVb
         X4OX7hzYs1rRSLrlXB7ujxcTwHk8ko1euOQuGLC/hLMFjgeMoEcCS04SwWap+g7aoSUL
         Zd0LFZ4M9adpK5LLyiEfRgfnTwwosbRJHL11EXkiymgvuE9EAUS6QF7qN7kJ5F5T0vLs
         /xdsg864tbCiKoZJk7nEvYbjQAIgjC5E2gNeMRWGzWEMj1RWhE6TQbIrEjvvRDaBP8TT
         5P7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691846420; x=1692451220;
        h=in-reply-to:from:references:cc:to:content-language:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EDc7FGjt9vfCAeRrYiucDZbfHTjKkmO7dLH7SMdwKVw=;
        b=XPCtncUExRQu/9+qdSJyMDpSX1B0d7rkU1WHC8wTSQewFtTkP3CCaQBlLMC49RYtSD
         ROphZJ0aJdZJehfO8+wbNICzcfmSNf8/w5n2co7iW8xbelQepMsavwyJ4pDhs1aa0ISY
         4hBpH2j4e+Gx7pcgRD0hUAy1ED2DeHyOs3+HKPDmO8NhUoJkpWXNQPhN+Gvt38X2/eDF
         K3yRk/MOHVZ4O/08ndJuFH2X9KLm0xu589FOiSFz7b5d44z/xAOFQ/rlt/x7CCtK6Jsv
         ZBHyVvbGft0ZeebNEC9jqe2J1L+6smyKqMEcWbO3yAcm2lv2aIuuMlatJyC5m6I766QD
         lBYA==
X-Gm-Message-State: AOJu0YwCBKlMM4Th2h8vNGtBPWDj93RqmrC9mJ/cynlNL8GwrvISuCai
        rglc20E7Fgm1KZOoxBi2Vd38FQ==
X-Google-Smtp-Source: AGHT+IEYfEqnFOVPpgAP8IC4K+JZvkFN73vVqtwLAaNbBqskNEO9vITVJlBPLjL3FWQsIhkPBMQHmA==
X-Received: by 2002:a05:6a20:9191:b0:12e:f6e6:882b with SMTP id v17-20020a056a20919100b0012ef6e6882bmr6593947pzd.1.1691846419834;
        Sat, 12 Aug 2023 06:20:19 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id fe23-20020a056a002f1700b0067b643b814csm4899983pfb.6.2023.08.12.06.20.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Aug 2023 06:20:18 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------YiiXzunqIdctwfaLqcw5ctp7"
Message-ID: <ec4f5e8f-d1db-4278-a144-ddedca0ae5ca@kernel.dk>
Date:   Sat, 12 Aug 2023 07:20:18 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] io_uring: correct check for O_TMPFILE"
 failed to apply to 5.15-stable tree
Content-Language: en-US
To:     gregkh@linuxfoundation.org, cyphar@cyphar.com
Cc:     stable@vger.kernel.org
References: <2023081258-sturdy-retying-2572@gregkh>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <2023081258-sturdy-retying-2572@gregkh>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

This is a multi-part message in MIME format.
--------------YiiXzunqIdctwfaLqcw5ctp7
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/12/23 12:02 AM, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 5.15-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
> 
> To reproduce the conflict and resubmit, you may use the following commands:
> 
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
> git checkout FETCH_HEAD
> git cherry-pick -x 72dbde0f2afbe4af8e8595a89c650ae6b9d9c36f
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023081258-sturdy-retying-2572@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Here's one for 5.15-stable.

-- 
Jens Axboe


--------------YiiXzunqIdctwfaLqcw5ctp7
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-io_uring-correct-check-for-O_TMPFILE.patch"
Content-Disposition: attachment;
 filename="0001-io_uring-correct-check-for-O_TMPFILE.patch"
Content-Transfer-Encoding: base64

RnJvbSA0MDU4ZmY1M2ZlMWE4MzFkYzgyYmNjNTFmNWE2NDI0ZThiMjhkMTU5IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBBbGVrc2EgU2FyYWkgPGN5cGhhckBjeXBoYXIuY29t
PgpEYXRlOiBTYXQsIDEyIEF1ZyAyMDIzIDA3OjE5OjA1IC0wNjAwClN1YmplY3Q6IFtQQVRD
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
IDxheGJvZUBrZXJuZWwuZGs+Ci0tLQogaW9fdXJpbmcvaW9fdXJpbmcuYyB8IDYgKysrKy0t
CiAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlm
ZiAtLWdpdCBhL2lvX3VyaW5nL2lvX3VyaW5nLmMgYi9pb191cmluZy9pb191cmluZy5jCmlu
ZGV4IDZmMWQ4OGJmZDY5MC4uN2M5OGE4MjBjOGRkIDEwMDY0NAotLS0gYS9pb191cmluZy9p
b191cmluZy5jCisrKyBiL2lvX3VyaW5nL2lvX3VyaW5nLmMKQEAgLTQzNzUsOSArNDM3NSwx
MSBAQCBzdGF0aWMgaW50IGlvX29wZW5hdDIoc3RydWN0IGlvX2tpb2NiICpyZXEsIHVuc2ln
bmVkIGludCBpc3N1ZV9mbGFncykKIAlpZiAoaXNzdWVfZmxhZ3MgJiBJT19VUklOR19GX05P
TkJMT0NLKSB7CiAJCS8qCiAJCSAqIERvbid0IGJvdGhlciB0cnlpbmcgZm9yIE9fVFJVTkMs
IE9fQ1JFQVQsIG9yIE9fVE1QRklMRSBvcGVuLAotCQkgKiBpdCdsbCBhbHdheXMgLUVBR0FJ
TgorCQkgKiBpdCdsbCBhbHdheXMgLUVBR0FJTi4gTm90ZSB0aGF0IHdlIHRlc3QgZm9yIF9f
T19UTVBGSUxFCisJCSAqIGJlY2F1c2UgT19UTVBGSUxFIGluY2x1ZGVzIE9fRElSRUNUT1JZ
LCB3aGljaCBpc24ndCBhIGZsYWcKKwkJICogd2UgbmVlZCB0byBmb3JjZSBhc3luYyBmb3Iu
CiAJCSAqLwotCQlpZiAocmVxLT5vcGVuLmhvdy5mbGFncyAmIChPX1RSVU5DIHwgT19DUkVB
VCB8IE9fVE1QRklMRSkpCisJCWlmIChyZXEtPm9wZW4uaG93LmZsYWdzICYgKE9fVFJVTkMg
fCBPX0NSRUFUIHwgX19PX1RNUEZJTEUpKQogCQkJcmV0dXJuIC1FQUdBSU47CiAJCW9wLmxv
b2t1cF9mbGFncyB8PSBMT09LVVBfQ0FDSEVEOwogCQlvcC5vcGVuX2ZsYWcgfD0gT19OT05C
TE9DSzsKLS0gCjIuNDAuMQoK

--------------YiiXzunqIdctwfaLqcw5ctp7--
