Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B505755036
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 20:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbjGPSIQ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 14:08:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjGPSIP (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 14:08:15 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52DCA1B0
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 11:08:14 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-66d6a9851f3so842141b3a.0
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 11:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1689530894; x=1692122894;
        h=in-reply-to:from:references:cc:to:content-language:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t0IgaeB7Kv5pYNGfOq4lhILsxk179XHRzG0fbhPkXU4=;
        b=RP/6ZoRdATecMQxfVTskp4lKHcfEZhw/+zd0FzmCSWX1i0zUSIrYDTiilp61jw4H4h
         ZRRzVarDk4yvzP93e9RpcFs35m2jfrfuab+BgK1eD9L64bSZzH8RFxddLEA5agtM2558
         QnRu8TPM+64rRM4y1E5zyYF16IcZ5rGDZQO0UwS8ajiiz3ePxstrkCLBEkDocL/15shV
         lRGiXrOFTR35OgggLiMiSxR+jkQd2DdXLhalQUsUsKzOgrAP9ykGeR/vEkpWGqlxEofQ
         FAtGAUg0nKi1KD3W/vgvUsyTKIzRkfHIMFnlV86TUOIslDgRZUi8Y+zHI4Ta4Vktu2br
         pTsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689530894; x=1692122894;
        h=in-reply-to:from:references:cc:to:content-language:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=t0IgaeB7Kv5pYNGfOq4lhILsxk179XHRzG0fbhPkXU4=;
        b=bsnjOYRxcvHxbZ3SeBBRTqCX21oe5YURiSlwRnXJOE0kEmtgOgaa49k+BSnT2UWJmu
         WuCpVdhEQ0qHsqTFBu6qh1N5APJ6mwWYGEunILK92jE9nfYTAeAwBetHpaFFMmY75u0k
         edLa2EyL4SJkSWeSwmmIJHbmT4JmS0xH2YN9xVKNwNMnzwIzVPy5rZXqLOkYudBZ3ilz
         HRoHpftfte8/5IUkD8OhEroffuvYPnXecp4zxtVIJNbZ4M0onlLHl1VtxZFLUcNVOC8W
         6PkvRNYhzl9zJQaiN7KaafyDALS6N/0ro4SA9vRwEQTh5FBFY6G1HgYASTZnZf+gXqCa
         ibWg==
X-Gm-Message-State: ABy/qLZyVR3P4z4s3buWNhFBYTGrszgn0poyczLyKmGWG6HTt/6y46ZF
        kFXarqs98So/ZtuwFdfBaKDzjQ==
X-Google-Smtp-Source: APBJJlGj7TUi0iFhoUobBkwHzLQuT1Y+QEyOSMgaDYIavLQfb1bLcBRQ5jvvlcEvS9fk//z/9/151Q==
X-Received: by 2002:a05:6a00:8d3:b0:677:bb4c:c321 with SMTP id s19-20020a056a0008d300b00677bb4cc321mr6864124pfu.0.1689530893624;
        Sun, 16 Jul 2023 11:08:13 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id c3-20020aa781c3000000b0067978a01246sm10826216pfn.14.2023.07.16.11.08.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Jul 2023 11:08:12 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------0T4hbi937NU0x2UomzD9X0GZ"
Message-ID: <e139b7d2-5105-88bf-d687-57f57813ad5b@kernel.dk>
Date:   Sun, 16 Jul 2023 12:08:11 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: FAILED: patch "[PATCH] io_uring: Use io_schedule* in cqring wait"
 failed to apply to 5.10-stable tree
Content-Language: en-US
To:     gregkh@linuxfoundation.org, andres@anarazel.de,
        asml.silence@gmail.com
Cc:     stable@vger.kernel.org
References: <2023071623-deafness-gargle-5297@gregkh>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <2023071623-deafness-gargle-5297@gregkh>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

This is a multi-part message in MIME format.
--------------0T4hbi937NU0x2UomzD9X0GZ
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/16/23 2:41 AM, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 5.10-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
> 
> To reproduce the conflict and resubmit, you may use the following commands:
> 
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
> git checkout FETCH_HEAD
> git cherry-pick -x 8a796565cec3601071cbbd27d6304e202019d014
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023071623-deafness-gargle-5297@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Here's one for 5.10-stable and 5.15-stable.

-- 
Jens Axboe


--------------0T4hbi937NU0x2UomzD9X0GZ
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-io_uring-Use-io_schedule-in-cqring-wait.patch"
Content-Disposition: attachment;
 filename="0001-io_uring-Use-io_schedule-in-cqring-wait.patch"
Content-Transfer-Encoding: base64

RnJvbSBiYzliYTExMTZjNTc4ODJkNzUzOWFmNjBhZGIxZWUzMjljNDZiNTU2IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBBbmRyZXMgRnJldW5kIDxhbmRyZXNAYW5hcmF6ZWwu
ZGU+CkRhdGU6IFN1biwgMTYgSnVsIDIwMjMgMTI6MDc6MDMgLTA2MDAKU3ViamVjdDogW1BB
VENIXSBpb191cmluZzogVXNlIGlvX3NjaGVkdWxlKiBpbiBjcXJpbmcgd2FpdAoKSSBvYnNl
cnZlZCBwb29yIHBlcmZvcm1hbmNlIG9mIGlvX3VyaW5nIGNvbXBhcmVkIHRvIHN5bmNocm9u
b3VzIElPLiBUaGF0CnR1cm5zIG91dCB0byBiZSBjYXVzZWQgYnkgZGVlcGVyIENQVSBpZGxl
IHN0YXRlcyBlbnRlcmVkIHdpdGggaW9fdXJpbmcsCmR1ZSB0byBpb191cmluZyB1c2luZyBw
bGFpbiBzY2hlZHVsZSgpLCB3aGVyZWFzIHN5bmNocm9ub3VzIElPIHVzZXMKaW9fc2NoZWR1
bGUoKS4KClRoZSBsb3NzZXMgZHVlIHRvIHRoaXMgYXJlIHN1YnN0YW50aWFsLiBPbiBteSBj
YXNjYWRlIGxha2Ugd29ya3N0YXRpb24sCnQvaW9fdXJpbmcgZnJvbSB0aGUgZmlvIHJlcG9z
aXRvcnkgZS5nLiB5aWVsZHMgcmVncmVzc2lvbnMgYmV0d2VlbiAyMCUKYW5kIDQwJSB3aXRo
IHRoZSBmb2xsb3dpbmcgY29tbWFuZDoKLi90L2lvX3VyaW5nIC1yIDUgLVgwIC1kIDEgLXMg
MSAtYyAxIC1wIDAgLVMkdXNlX3N5bmMgLVIgMCAvbW50L3QyL2Zpby93cml0ZS4wLjAKClRo
aXMgaXMgcmVwZWF0YWJsZSB3aXRoIGRpZmZlcmVudCBmaWxlc3lzdGVtcywgdXNpbmcgcmF3
IGJsb2NrIGRldmljZXMKYW5kIHVzaW5nIGRpZmZlcmVudCBibG9jayBkZXZpY2VzLgoKVXNl
IGlvX3NjaGVkdWxlX3ByZXBhcmUoKSAvIGlvX3NjaGVkdWxlX2ZpbmlzaCgpIGluCmlvX2Nx
cmluZ193YWl0X3NjaGVkdWxlKCkgdG8gYWRkcmVzcyB0aGUgZGlmZmVyZW5jZS4KCkFmdGVy
IHRoYXQgdXNpbmcgaW9fdXJpbmcgaXMgb24gcGFyIG9yIHN1cnBhc3Npbmcgc3luY2hyb25v
dXMgSU8gKHVzaW5nCnJlZ2lzdGVyZWQgZmlsZXMgZXRjIG1ha2VzIGl0IHJlbGlhYmx5IHdp
biwgYnV0IGFyZ3VhYmx5IGlzIGEgbGVzcyBmYWlyCmNvbXBhcmlzb24pLgoKVGhlcmUgYXJl
IG90aGVyIGNhbGxzIHRvIHNjaGVkdWxlKCkgaW4gaW9fdXJpbmcvLCBidXQgbm9uZSBpbW1l
ZGlhdGVseQpqdW1wIG91dCB0byBiZSBzaW1pbGFybHkgc2l0dWF0ZWQsIHNvIEkgZGlkIG5v
dCB0b3VjaCB0aGVtLiBTaW1pbGFybHksCml0J3MgcG9zc2libGUgdGhhdCBtdXRleF9sb2Nr
X2lvKCkgc2hvdWxkIGJlIHVzZWQsIGJ1dCBpdCdzIG5vdCBjbGVhciBpZgp0aGVyZSBhcmUg
Y2FzZXMgd2hlcmUgdGhhdCBtYXR0ZXJzLgoKQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcg
IyA1LjEwKwpDYzogUGF2ZWwgQmVndW5rb3YgPGFzbWwuc2lsZW5jZUBnbWFpbC5jb20+CkNj
OiBpby11cmluZ0B2Z2VyLmtlcm5lbC5vcmcKQ2M6IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5l
bC5vcmcKU2lnbmVkLW9mZi1ieTogQW5kcmVzIEZyZXVuZCA8YW5kcmVzQGFuYXJhemVsLmRl
PgpMaW5rOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9yLzIwMjMwNzA3MTYyMDA3LjE5NDA2
OC0xLWFuZHJlc0BhbmFyYXplbC5kZQpbYXhib2U6IG1pbm9yIHN0eWxlIGZpeHVwXQpTaWdu
ZWQtb2ZmLWJ5OiBKZW5zIEF4Ym9lIDxheGJvZUBrZXJuZWwuZGs+Ci0tLQogaW9fdXJpbmcv
aW9fdXJpbmcuYyB8IDE0ICsrKysrKysrKysrLS0tCiAxIGZpbGUgY2hhbmdlZCwgMTEgaW5z
ZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9pb191cmluZy9pb191
cmluZy5jIGIvaW9fdXJpbmcvaW9fdXJpbmcuYwppbmRleCBlNjMzNzk5YzljZWEuLjAxMGNj
MDZkZjRlOSAxMDA2NDQKLS0tIGEvaW9fdXJpbmcvaW9fdXJpbmcuYworKysgYi9pb191cmlu
Zy9pb191cmluZy5jCkBAIC03Nzg1LDcgKzc3ODUsNyBAQCBzdGF0aWMgaW5saW5lIGludCBp
b19jcXJpbmdfd2FpdF9zY2hlZHVsZShzdHJ1Y3QgaW9fcmluZ19jdHggKmN0eCwKIAkJCQkJ
ICBzdHJ1Y3QgaW9fd2FpdF9xdWV1ZSAqaW93cSwKIAkJCQkJICBrdGltZV90ICp0aW1lb3V0
KQogewotCWludCByZXQ7CisJaW50IHRva2VuLCByZXQ7CiAKIAkvKiBtYWtlIHN1cmUgd2Ug
cnVuIHRhc2tfd29yayBiZWZvcmUgY2hlY2tpbmcgZm9yIHNpZ25hbHMgKi8KIAlyZXQgPSBp
b19ydW5fdGFza193b3JrX3NpZygpOwpAQCAtNzc5NSw5ICs3Nzk1LDE3IEBAIHN0YXRpYyBp
bmxpbmUgaW50IGlvX2NxcmluZ193YWl0X3NjaGVkdWxlKHN0cnVjdCBpb19yaW5nX2N0eCAq
Y3R4LAogCWlmICh0ZXN0X2JpdCgwLCAmY3R4LT5jaGVja19jcV9vdmVyZmxvdykpCiAJCXJl
dHVybiAxOwogCisJLyoKKwkgKiBVc2UgaW9fc2NoZWR1bGVfcHJlcGFyZS9maW5pc2gsIHNv
IGNwdWZyZXEgY2FuIHRha2UgaW50byBhY2NvdW50CisJICogdGhhdCB0aGUgdGFzayBpcyB3
YWl0aW5nIGZvciBJTyAtIHR1cm5zIG91dCB0byBiZSBpbXBvcnRhbnQgZm9yIGxvdworCSAq
IFFEIElPLgorCSAqLworCXRva2VuID0gaW9fc2NoZWR1bGVfcHJlcGFyZSgpOworCXJldCA9
IDA7CiAJaWYgKCFzY2hlZHVsZV9ocnRpbWVvdXQodGltZW91dCwgSFJUSU1FUl9NT0RFX0FC
UykpCi0JCXJldHVybiAtRVRJTUU7Ci0JcmV0dXJuIDE7CisJCXJldCA9IC1FVElNRTsKKwlp
b19zY2hlZHVsZV9maW5pc2godG9rZW4pOworCXJldHVybiByZXQ7CiB9CiAKIC8qCi0tIAoy
LjQwLjEKCg==

--------------0T4hbi937NU0x2UomzD9X0GZ--
