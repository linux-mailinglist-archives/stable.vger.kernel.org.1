Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF13A76B7F8
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 16:48:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234897AbjHAOsr (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 10:48:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234900AbjHAOsj (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 10:48:39 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 995661BF1
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 07:48:38 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id e9e14a558f8ab-346434c7793so4112985ab.0
        for <stable@vger.kernel.org>; Tue, 01 Aug 2023 07:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1690901318; x=1691506118;
        h=in-reply-to:from:references:cc:to:content-language:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kIp6d1eRB9fN05Eegqd+St4srF5d6fjCPhotA+YQVWM=;
        b=WvyYYJcXaF8KQdAm2Y0CMBxx9J2z22227xMMdrUqcORDZVEG2ImuD4VmbeEHGUEL+S
         CZonhrdOXuINrTBsQAtky3yvX2g6NPZKRxsFq53DlVgsCi9vocUtLsNFz23mgQy4vs3j
         uXI7V7I/s2rDNjEF5G0gdQ2NDCWiK0gtS1LchTcRe0XPsRd4uK5Pwmses9YZCh9l4XgG
         u2i544hqHvQahfgUM3isDs3T7kpdfUVYEKOZW5xHDRpfHKHnygA/wm82Ilm6PNk4zdbt
         MqB0pet9wTG+VZuiVeQaSbDW4Ip/tZNx7tBjJDCF4u5U9nuasD7yfJwY6ctpXl1TM544
         Np7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690901318; x=1691506118;
        h=in-reply-to:from:references:cc:to:content-language:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kIp6d1eRB9fN05Eegqd+St4srF5d6fjCPhotA+YQVWM=;
        b=fjZob5Zapm12BOsJsRAqivh19CkRSv1oikAqqwipg49/o5tcJyjRzJXyndzMJzS11b
         hxaIEafT2k0pOYtnahoZiISpxYRSSXVkxVUQCapQqXUFu+HJEYyVKc5MmyJYTo9n3M0j
         R1DX9WqBM2czETVLAdQrSAmqEtpZzfVsG5Phxh0SXiLT/uRLEWu3KaUfJL5qzAw8Y5Co
         Z/d/MsugxL0SNtEBJ3rqu8mNQj8IJMgBksKninK6eMbrgXLwRYpDicsU50VLNSqDBZGb
         /0+d9VYgvPv0e6vR+ekfaGNGP/Hon443ztkH5zziUxZAUh5WFv8H6IWXPdqt/DFovd+F
         llRA==
X-Gm-Message-State: ABy/qLbDHJCZ3ng50X+oZA+y+2xMES2PuwR/0dl2ijDgoHPf8RKtCTMN
        UU1gGwpJUUbZUyiKGpPnkpPKosHDTaP9cadLmBU=
X-Google-Smtp-Source: APBJJlFxYbRVHoMZqEbsT1+rGHiSPYaRvToODe5cUb0DO/iphvcXi4x1bw56Qxn7LGPRqMu5eazCWg==
X-Received: by 2002:a6b:c9d3:0:b0:788:2d78:813c with SMTP id z202-20020a6bc9d3000000b007882d78813cmr11515391iof.0.1690901317976;
        Tue, 01 Aug 2023 07:48:37 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id k6-20020a02ccc6000000b0042b1d495aecsm3845920jaq.123.2023.08.01.07.48.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Aug 2023 07:48:37 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------dalk8Dngx0CPNKPdfQ6qpn74"
Message-ID: <c2516403-4aff-375b-a519-9fb815c7d4bb@kernel.dk>
Date:   Tue, 1 Aug 2023 08:48:36 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: FAILED: patch "[PATCH] io_uring: gate iowait schedule on having
 pending requests" failed to apply to 6.1-stable tree
Content-Language: en-US
To:     gregkh@linuxfoundation.org, andres@anarazel.de,
        oleksandr@natalenko.name, phil@raspberrypi.com
Cc:     stable@vger.kernel.org
References: <2023080153-turkey-reload-8fa7@gregkh>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <2023080153-turkey-reload-8fa7@gregkh>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

This is a multi-part message in MIME format.
--------------dalk8Dngx0CPNKPdfQ6qpn74
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/31/23 11:53 PM, gregkh@linuxfoundation.org wrote:
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
> git cherry-pick -x 7b72d661f1f2f950ab8c12de7e2bc48bdac8ed69
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023080153-turkey-reload-8fa7@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Here's one that applies to 6.1-stable.

-- 
Jens Axboe


--------------dalk8Dngx0CPNKPdfQ6qpn74
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-io_uring-gate-iowait-schedule-on-having-pending-requ.patch"
Content-Disposition: attachment;
 filename*0="0001-io_uring-gate-iowait-schedule-on-having-pending-requ.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSAwODEzMDE5NWQzNDQ3NmJmYmM2M2M1MzUzMmY5NTI0NWFiZmNmZTZkIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBKZW5zIEF4Ym9lIDxheGJvZUBrZXJuZWwuZGs+CkRh
dGU6IFR1ZSwgMSBBdWcgMjAyMyAwODo0MjozNyAtMDYwMApTdWJqZWN0OiBbUEFUQ0hdIGlv
X3VyaW5nOiBnYXRlIGlvd2FpdCBzY2hlZHVsZSBvbiBoYXZpbmcgcGVuZGluZyByZXF1ZXN0
cwoKQ29tbWl0IDdiNzJkNjYxZjFmMmY5NTBhYjhjMTJkZTdlMmJjNDhiZGFjOGVkNjkgdXBz
dHJlYW0uCgpBIHByZXZpb3VzIGNvbW1pdCBtYWRlIGFsbCBjcXJpbmcgd2FpdHMgbWFya2Vk
IGFzIGlvd2FpdCwgYXMgYSB3YXkgdG8KaW1wcm92ZSBwZXJmb3JtYW5jZSBmb3Igc2hvcnQg
c2NoZWR1bGVzIHdpdGggcGVuZGluZyBJTy4gSG93ZXZlciwgZm9yCnVzZSBjYXNlcyB0aGF0
IGhhdmUgYSBzcGVjaWFsIHJlYXBlciB0aHJlYWQgdGhhdCBkb2VzIG5vdGhpbmcgYnV0Cndh
aXQgb24gZXZlbnRzIG9uIHRoZSByaW5nLCB0aGlzIGNhdXNlcyBhIGNvc21ldGljIGlzc3Vl
IHdoZXJlIHdlCmtub3cgaGF2ZSBvbmUgY29yZSBtYXJrZWQgYXMgYmVpbmcgImJ1c3kiIHdp
dGggMTAwJSBpb3dhaXQuCgpXaGlsZSB0aGlzIGlzbid0IGEgZ3JhdmUgaXNzdWUsIGl0IGlz
IGNvbmZ1c2luZyB0byB1c2Vycy4gUmF0aGVyIHRoYW4KYWx3YXlzIG1hcmsgdXMgYXMgYmVp
bmcgaW4gaW93YWl0LCBnYXRlIHNldHRpbmcgb2YgY3VycmVudC0+aW5faW93YWl0CnRvIDEg
Ynkgd2hldGhlciBvciBub3QgdGhlIHdhaXRpbmcgdGFzayBoYXMgcGVuZGluZyByZXF1ZXN0
cy4KCkNjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnCkxpbms6IGh0dHBzOi8vbG9yZS5rZXJu
ZWwub3JnL2lvLXVyaW5nL0NBTUVHSkoyUnhvcGZOUTdHTkxocjdYOT1iSFhLbytHNU9PZTBM
VXE9K1VnTFhzdjFYZ0BtYWlsLmdtYWlsLmNvbS8KTGluazogaHR0cHM6Ly9idWd6aWxsYS5r
ZXJuZWwub3JnL3Nob3dfYnVnLmNnaT9pZD0yMTc2OTkKTGluazogaHR0cHM6Ly9idWd6aWxs
YS5rZXJuZWwub3JnL3Nob3dfYnVnLmNnaT9pZD0yMTc3MDAKUmVwb3J0ZWQtYnk6IE9sZWtz
YW5kciBOYXRhbGVua28gPG9sZWtzYW5kckBuYXRhbGVua28ubmFtZT4KUmVwb3J0ZWQtYnk6
IFBoaWwgRWx3ZWxsIDxwaGlsQHJhc3BiZXJyeXBpLmNvbT4KVGVzdGVkLWJ5OiBBbmRyZXMg
RnJldW5kIDxhbmRyZXNAYW5hcmF6ZWwuZGU+CkZpeGVzOiA4YTc5NjU2NWNlYzMgKCJpb191
cmluZzogVXNlIGlvX3NjaGVkdWxlKiBpbiBjcXJpbmcgd2FpdCIpClNpZ25lZC1vZmYtYnk6
IEplbnMgQXhib2UgPGF4Ym9lQGtlcm5lbC5kaz4KLS0tCiBpb191cmluZy9pb191cmluZy5j
IHwgMjMgKysrKysrKysrKysrKysrKystLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAxNyBpbnNl
cnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2lvX3VyaW5nL2lvX3Vy
aW5nLmMgYi9pb191cmluZy9pb191cmluZy5jCmluZGV4IGJkN2I4Y2Y4YmM2Ny4uMzgxYjlk
NTNkYTYyIDEwMDY0NAotLS0gYS9pb191cmluZy9pb191cmluZy5jCisrKyBiL2lvX3VyaW5n
L2lvX3VyaW5nLmMKQEAgLTIzNDksMTIgKzIzNDksMjEgQEAgaW50IGlvX3J1bl90YXNrX3dv
cmtfc2lnKHN0cnVjdCBpb19yaW5nX2N0eCAqY3R4KQogCXJldHVybiAwOwogfQogCitzdGF0
aWMgYm9vbCBjdXJyZW50X3BlbmRpbmdfaW8odm9pZCkKK3sKKwlzdHJ1Y3QgaW9fdXJpbmdf
dGFzayAqdGN0eCA9IGN1cnJlbnQtPmlvX3VyaW5nOworCisJaWYgKCF0Y3R4KQorCQlyZXR1
cm4gZmFsc2U7CisJcmV0dXJuIHBlcmNwdV9jb3VudGVyX3JlYWRfcG9zaXRpdmUoJnRjdHgt
PmluZmxpZ2h0KTsKK30KKwogLyogd2hlbiByZXR1cm5zID4wLCB0aGUgY2FsbGVyIHNob3Vs
ZCByZXRyeSAqLwogc3RhdGljIGlubGluZSBpbnQgaW9fY3FyaW5nX3dhaXRfc2NoZWR1bGUo
c3RydWN0IGlvX3JpbmdfY3R4ICpjdHgsCiAJCQkJCSAgc3RydWN0IGlvX3dhaXRfcXVldWUg
Kmlvd3EsCiAJCQkJCSAga3RpbWVfdCAqdGltZW91dCkKIHsKLQlpbnQgdG9rZW4sIHJldDsK
KwlpbnQgaW9fd2FpdCwgcmV0OwogCXVuc2lnbmVkIGxvbmcgY2hlY2tfY3E7CiAKIAkvKiBt
YWtlIHN1cmUgd2UgcnVuIHRhc2tfd29yayBiZWZvcmUgY2hlY2tpbmcgZm9yIHNpZ25hbHMg
Ki8KQEAgLTIzNzIsMTUgKzIzODEsMTcgQEAgc3RhdGljIGlubGluZSBpbnQgaW9fY3FyaW5n
X3dhaXRfc2NoZWR1bGUoc3RydWN0IGlvX3JpbmdfY3R4ICpjdHgsCiAJfQogCiAJLyoKLQkg
KiBVc2UgaW9fc2NoZWR1bGVfcHJlcGFyZS9maW5pc2gsIHNvIGNwdWZyZXEgY2FuIHRha2Ug
aW50byBhY2NvdW50Ci0JICogdGhhdCB0aGUgdGFzayBpcyB3YWl0aW5nIGZvciBJTyAtIHR1
cm5zIG91dCB0byBiZSBpbXBvcnRhbnQgZm9yIGxvdwotCSAqIFFEIElPLgorCSAqIE1hcmsg
dXMgYXMgYmVpbmcgaW4gaW9fd2FpdCBpZiB3ZSBoYXZlIHBlbmRpbmcgcmVxdWVzdHMsIHNv
IGNwdWZyZXEKKwkgKiBjYW4gdGFrZSBpbnRvIGFjY291bnQgdGhhdCB0aGUgdGFzayBpcyB3
YWl0aW5nIGZvciBJTyAtIHR1cm5zIG91dAorCSAqIHRvIGJlIGltcG9ydGFudCBmb3IgbG93
IFFEIElPLgogCSAqLwotCXRva2VuID0gaW9fc2NoZWR1bGVfcHJlcGFyZSgpOworCWlvX3dh
aXQgPSBjdXJyZW50LT5pbl9pb3dhaXQ7CisJaWYgKGN1cnJlbnRfcGVuZGluZ19pbygpKQor
CQljdXJyZW50LT5pbl9pb3dhaXQgPSAxOwogCXJldCA9IDE7CiAJaWYgKCFzY2hlZHVsZV9o
cnRpbWVvdXQodGltZW91dCwgSFJUSU1FUl9NT0RFX0FCUykpCiAJCXJldCA9IC1FVElNRTsK
LQlpb19zY2hlZHVsZV9maW5pc2godG9rZW4pOworCWN1cnJlbnQtPmluX2lvd2FpdCA9IGlv
X3dhaXQ7CiAJcmV0dXJuIHJldDsKIH0KIAotLSAKMi40MC4xCgo=

--------------dalk8Dngx0CPNKPdfQ6qpn74--
