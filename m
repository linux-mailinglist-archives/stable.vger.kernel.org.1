Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7740733DBF
	for <lists+stable@lfdr.de>; Sat, 17 Jun 2023 05:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233822AbjFQDPb (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 16 Jun 2023 23:15:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231806AbjFQDPa (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 16 Jun 2023 23:15:30 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8374B1B1
        for <stable@vger.kernel.org>; Fri, 16 Jun 2023 20:15:28 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-543a37c5c03so286285a12.1
        for <stable@vger.kernel.org>; Fri, 16 Jun 2023 20:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1686971727; x=1689563727;
        h=subject:from:to:content-language:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vh0wk0e0KC5laaVvrNLixGz4cBdwSjnztEifNjtVXzc=;
        b=cTJo2sip1nl2eNS9aLfdXj/b5DMD8ukyXUiIWC1zTOVPHBKadOoQGSfVQ3i9zZd6x4
         i/7bYlRQcF9uG0pN6uYV6nfHepdUC0nkFyLE4aoCIh63DXHMHHlIByK1WR+31DcQB6A/
         BpQXuk5nvwg1am6ixLWRrSQK51TlUvuFNRKbUxlDxyCvIwqPvdJh2iAOXJ9c8UkLXWBD
         Djk0MMy4m9vqGF7GTjx14XpNcH+O+ZBU/z1EB8lMLmHcxiQRv4xvRVPh3MlF+7roDIIY
         AlI6CpNut1CO/p8IRPLX9XsKQ0WsWm7s5kRi+xJxNxnYF3BMtH/8mT8TmbdQEMz0RtGA
         Vtfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686971727; x=1689563727;
        h=subject:from:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vh0wk0e0KC5laaVvrNLixGz4cBdwSjnztEifNjtVXzc=;
        b=huU2JtQVTJFLu9cfwN0SOVoqUw/bTOddEP1pgh4ftLqzNEdtUAPQqSX2ENvjHxZMPM
         2RHkf6YUQiMik6omPo+lZ02knIrIt2CFcWDvGtWXf/6k+79P0bfkv2yv9gfi8Gu+tP0l
         8jyq2aKtoLAqwlLJolpA0SJE4aZeNKkpB3AKuJKmm7UmNU+i8ocMMYdnit/wl80L4IRm
         fQBZltgHxHiXOIgaLwm5BUmeqgv30XlDCVlZ21XmIuy3TgwfoD1N2fVnvTpFg4wcLmiK
         Tq+ymkA8clzxvvBTUHSXAX5PsJxqxrLTeghO0QykeyLt5av7oVvuyFm8wphPAPjJgcib
         H/xA==
X-Gm-Message-State: AC+VfDwSBOL3GbkTv7DQnbKQ34QJF6UXfq1r0VPAWwFPk2u50RhmI2sC
        bv+g+8Llxq3O/lohZ1sJpGX+0eRWSfTP3IT+VQ0=
X-Google-Smtp-Source: ACHHUZ5ZbcRwgLJ+0hD4TSfObRAPV+eLIoeldDP1KCkVtH8hTimuB/WRCNgQvlvR0DMLPZVNBm8JIg==
X-Received: by 2002:a17:90b:1b0c:b0:252:b342:a84a with SMTP id nu12-20020a17090b1b0c00b00252b342a84amr4502174pjb.0.1686971727426;
        Fri, 16 Jun 2023 20:15:27 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id r91-20020a17090a43e400b00256dff5f8e3sm2114710pjg.49.2023.06.16.20.15.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jun 2023 20:15:26 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------j14MZxDypTPsEn1yD4VSzTgc"
Message-ID: <0a921aec-9e55-e83c-1a9e-4f25e19d4195@kernel.dk>
Date:   Fri, 16 Jun 2023 21:15:25 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
To:     stable <stable@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: io_uring fix for 5.10 and 5.15 stable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

This is a multi-part message in MIME format.
--------------j14MZxDypTPsEn1yD4VSzTgc
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

Here's a fix that should go into 5.10-stable and 5.15-stable.
Greg, can you get this applied? Thanks!

-- 
Jens Axboe

--------------j14MZxDypTPsEn1yD4VSzTgc
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-io_uring-hold-uring-mutex-around-poll-removal.patch"
Content-Disposition: attachment;
 filename="0001-io_uring-hold-uring-mutex-around-poll-removal.patch"
Content-Transfer-Encoding: base64

RnJvbSAzZjFmMDUyYTVmOGUyZjljNTY4YzRlMGEzNDA1N2I5MDQ5ZTk0OGQ5IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBKZW5zIEF4Ym9lIDxheGJvZUBrZXJuZWwuZGs+CkRh
dGU6IEZyaSwgMTYgSnVuIDIwMjMgMjE6MTI6MDYgLTA2MDAKU3ViamVjdDogW1BBVENIXSBp
b191cmluZzogaG9sZCB1cmluZyBtdXRleCBhcm91bmQgcG9sbCByZW1vdmFsCgpTbmlwcGVk
IGZyb20gY29tbWl0IDljYTlmYjI0ZDVmZWJjY2VhMzU0MDg5YzQxZjk2YThhZDBkODUzZjgg
dXBzdHJlYW0uCgpXaGlsZSByZXdvcmtpbmcgdGhlIHBvbGwgaGFzaGluZyBpbiB0aGUgdjYu
MCBrZXJuZWwsIHdlIGVuZGVkIHVwCmdyYWJiaW5nIHRoZSBjdHgtPnVyaW5nX2xvY2sgaW4g
cG9sbCB1cGRhdGUvcmVtb3ZhbC4gVGhpcyBhbHNvIGZpeGVkCmEgYnVnIHdpdGggbGlua2Vk
IHRpbWVvdXRzIHJhY2luZyB3aXRoIHRpbWVvdXQgZXhwaXJ5IGFuZCBwb2xsCnJlbW92YWwu
CgpCcmluZyBiYWNrIGp1c3QgdGhlIGxvY2tpbmcgZml4IGZvciB0aGF0LgoKUmVwb3J0ZWQt
YW5kLXRlc3RlZC1ieTogUXVlcmlqbiBWb2V0IDxxdWVyaWpucXluQGdtYWlsLmNvbT4KU2ln
bmVkLW9mZi1ieTogSmVucyBBeGJvZSA8YXhib2VAa2VybmVsLmRrPgotLS0KIGlvX3VyaW5n
L2lvX3VyaW5nLmMgfCAzICsrKwogMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKQoK
ZGlmZiAtLWdpdCBhL2lvX3VyaW5nL2lvX3VyaW5nLmMgYi9pb191cmluZy9pb191cmluZy5j
CmluZGV4IDJkNmYyNzVkMTgwZS4uMWQ4YWRjNTdhNDRhIDEwMDY0NAotLS0gYS9pb191cmlu
Zy9pb191cmluZy5jCisrKyBiL2lvX3VyaW5nL2lvX3VyaW5nLmMKQEAgLTYxMTEsNiArNjEx
MSw4IEBAIHN0YXRpYyBpbnQgaW9fcG9sbF91cGRhdGUoc3RydWN0IGlvX2tpb2NiICpyZXEs
IHVuc2lnbmVkIGludCBpc3N1ZV9mbGFncykKIAlzdHJ1Y3QgaW9fa2lvY2IgKnByZXE7CiAJ
aW50IHJldDIsIHJldCA9IDA7CiAKKwlpb19yaW5nX3N1Ym1pdF9sb2NrKGN0eCwgIShpc3N1
ZV9mbGFncyAmIElPX1VSSU5HX0ZfTk9OQkxPQ0spKTsKKwogCXNwaW5fbG9jaygmY3R4LT5j
b21wbGV0aW9uX2xvY2spOwogCXByZXEgPSBpb19wb2xsX2ZpbmQoY3R4LCByZXEtPnBvbGxf
dXBkYXRlLm9sZF91c2VyX2RhdGEsIHRydWUpOwogCWlmICghcHJlcSB8fCAhaW9fcG9sbF9k
aXNhcm0ocHJlcSkpIHsKQEAgLTYxNDIsNiArNjE0NCw3IEBAIHN0YXRpYyBpbnQgaW9fcG9s
bF91cGRhdGUoc3RydWN0IGlvX2tpb2NiICpyZXEsIHVuc2lnbmVkIGludCBpc3N1ZV9mbGFn
cykKIAkJcmVxX3NldF9mYWlsKHJlcSk7CiAJLyogY29tcGxldGUgdXBkYXRlIHJlcXVlc3Qs
IHdlJ3JlIGRvbmUgd2l0aCBpdCAqLwogCWlvX3JlcV9jb21wbGV0ZShyZXEsIHJldCk7CisJ
aW9fcmluZ19zdWJtaXRfdW5sb2NrKGN0eCwgIShpc3N1ZV9mbGFncyAmIElPX1VSSU5HX0Zf
Tk9OQkxPQ0spKTsKIAlyZXR1cm4gMDsKIH0KIAotLSAKMi4zOS4yCgo=

--------------j14MZxDypTPsEn1yD4VSzTgc--
