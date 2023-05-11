Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD9366FE854
	for <lists+stable@lfdr.de>; Thu, 11 May 2023 02:09:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236798AbjEKAJI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 10 May 2023 20:09:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230374AbjEKAJH (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 10 May 2023 20:09:07 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3866A2698
        for <stable@vger.kernel.org>; Wed, 10 May 2023 17:09:06 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id ca18e2360f4ac-76c6e795650so7836039f.1
        for <stable@vger.kernel.org>; Wed, 10 May 2023 17:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683763745; x=1686355745;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Za2+jeiZw/3wYekYEcyNuKWRaZXywYW0iW1LDK1f/HU=;
        b=ZiwmtkBHIB6aW64jOpaHctuZvkF7ESJmvil7usV3leHQSPb/UcbvRXBgCF6xTr5coB
         HxXuqoQUv5Tc0vO0RKhebrjbdMjIsKtnaTfN2ez1wEnBhhjMW1oByKwmhX7/kGtCligs
         8gr91AOSkmdf5twGZ3pvZrCra/CvAZM5Ec02b94x6dAx7RC9tIax+2uMvPIZI8t/3KUi
         4I5ppke0sbSDxHSeUlbhuIX4eMwf1SpkUngcpw0OkWdFShSx+xJiPhiYXgkF1UVq74uw
         eGlFKEBP7iUcADz5ZqeKoJxyOy4r7sasvOUpoKOdX77klXjAZXPkwvZO+FV1FZmySz8Q
         4YkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683763745; x=1686355745;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Za2+jeiZw/3wYekYEcyNuKWRaZXywYW0iW1LDK1f/HU=;
        b=VULWqw5PjwzzN/wlnfsh/ht7Lis4QbwTHSUnvcMF9VXRubpmzx+vQH9zQYRHLd8Ri0
         ly5il/rKI8uT+vi9/TB1Of1xEyZRSRLj32J/hg+zvuWMITd64lXQli5UkhqKz1aBpTO1
         tmvb9EoYq0Ppa4xr7hm/UC99b7Kjh4qNEpCuE5908KFpMGwYEzoh0EQlGzdr/9iXyAEH
         jSoTO31cg3svn0PPPsFzheEq7gv2o7tQwm7wkdxTCHyrO/1n9VA3j8ucWqQzBtOkupqK
         KTKpP0LR8t/YwyFOx/HspRavC7exmXrvAf/5weRHcww8ft73TYQ/80N64PX+Fzt3yV2/
         E9Bg==
X-Gm-Message-State: AC+VfDy3Pxfhv79tk7epWAEDljK1w6ALIap2C5l2MKZCJJpAktNJH6jN
        eVZQ0/jDYJtCJvMx6DxFxpm9i59b4ZmMfQ9Z1sA=
X-Google-Smtp-Source: ACHHUZ6BmM4QA43w2gB7zni4isOkOLF7ek1Fv3KU1Llkt2q3gyKPka4hUTH3UICV4/ciEkV6J9f4idUiJmUcMA4wow8=
X-Received: by 2002:a05:6e02:1b08:b0:331:1267:31f9 with SMTP id
 i8-20020a056e021b0800b00331126731f9mr9653791ilv.0.1683763744591; Wed, 10 May
 2023 17:09:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230409164229.29777-1-ping.cheng@wacom.com> <CAF8JNhJudYKrzBuyaT5aYy+fzeaxtB6HALRrbHwYzjcwz+=S0g@mail.gmail.com>
 <ZFmxMO6IyJx2/R1O@debian.me> <2023050922-zoologist-untaken-d73d@gregkh>
In-Reply-To: <2023050922-zoologist-untaken-d73d@gregkh>
From:   Ping Cheng <pinglinux@gmail.com>
Date:   Wed, 10 May 2023 17:06:03 -0700
Message-ID: <CAF8JNhJ9Q6+7O1pK-8SK_LYiJLsNYJLMyCaZbY73+1=-9jwdHw@mail.gmail.com>
Subject: Re: [PATCH] HID: wacom: Set a default resolution for older tablets
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux Stable <stable@vger.kernel.org>
Content-Type: multipart/mixed; boundary="000000000000e1e9dd05fb5fcb3c"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

--000000000000e1e9dd05fb5fcb3c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 8, 2023 at 7:44=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org>=
 wrote:
>
> On Tue, May 09, 2023 at 09:34:24AM +0700, Bagas Sanjaya wrote:
> > On Mon, May 08, 2023 at 06:05:02PM -0700, Ping Cheng wrote:
> > > Hi Stable maintainers,
> > >
> > > This patch, ID 08a46b4190d3, fixes an issue for a few older devices.
> > > It can be backported as is to all the current Long Term Supported
> > > kernels.
> > >
> >
> > Now that your fix has been upstreamed, can you provide a backport
> > for each supported stable versions (v4.14 up to v6.3)?

To speed up the process, I tested the patch on all stable branches.
The upstream patch can be APPLIED to kernels 5.15 and later, AS IS.

The attached patch applies to kernels 4.14 to 5.10. If you'd like me
to send the patch in a separate email, please let me know. Thank you
for your effort!

> Why? That's not needed if the commit can be cherry-picked cleanly
> everywhere.

Thank you @Greg KH  for your support. The Linux community would not
have got this far without people like you!

Cheers,
Ping

--000000000000e1e9dd05fb5fcb3c
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-HID-wacom-Set-a-default-resolution-for-older-tablets.patch"
Content-Disposition: attachment; 
	filename="0001-HID-wacom-Set-a-default-resolution-for-older-tablets.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_lhidb8sx0>
X-Attachment-Id: f_lhidb8sx0

RnJvbSAzZWVmNjlkODQ5MDFmMWQ0MzY5YTQzNmY4N2IzMDQ5ZTQzMGI0YjM3IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBQaW5nIENoZW5nIDxwaW5nLmNoZW5nQHdhY29tLmNvbT4KRGF0
ZTogV2VkLCAxMCBNYXkgMjAyMyAxMDoyMDoxNCAtMDcwMApTdWJqZWN0OiBbUEFUQ0ggTG9uZ3Rl
cm0gNC4xMSAxLzVdIEhJRDogd2Fjb206IFNldCBhIGRlZmF1bHQgcmVzb2x1dGlvbiBmb3Igb2xk
ZXIgdGFibGV0cwoKU29tZSBvbGRlciB0YWJsZXRzIG1heSBub3QgcmVwb3J0IHBoeXNpY2FsIG1h
eGltdW0gZm9yIFgvWQpjb29yZGluYXRlcy4gU2V0IGEgZGVmYXVsdCB0byBwcmV2ZW50IHVuZGVm
aW5lZCByZXNvbHV0aW9uLgoKU2lnbmVkLW9mZi1ieTogUGluZyBDaGVuZyA8cGluZy5jaGVuZ0B3
YWNvbS5jb20+Ci0tLQogZHJpdmVycy9oaWQvd2Fjb21fd2FjLmMgfCAxMiArKysrKysrKysrLS0K
IDEgZmlsZSBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAt
LWdpdCBhL2RyaXZlcnMvaGlkL3dhY29tX3dhYy5jIGIvZHJpdmVycy9oaWQvd2Fjb21fd2FjLmMK
aW5kZXggNDE3ZTEwODM1NTZiLi45MjFkNTE4NDE5NmQgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvaGlk
L3dhY29tX3dhYy5jCisrKyBiL2RyaXZlcnMvaGlkL3dhY29tX3dhYy5jCkBAIC0xNzM0LDYgKzE3
MzQsNyBAQCBzdGF0aWMgdm9pZCB3YWNvbV9tYXBfdXNhZ2Uoc3RydWN0IGlucHV0X2RldiAqaW5w
dXQsIHN0cnVjdCBoaWRfdXNhZ2UgKnVzYWdlLAogCWludCBmbWF4ID0gZmllbGQtPmxvZ2ljYWxf
bWF4aW11bTsKIAl1bnNpZ25lZCBpbnQgZXF1aXZhbGVudF91c2FnZSA9IHdhY29tX2VxdWl2YWxl
bnRfdXNhZ2UodXNhZ2UtPmhpZCk7CiAJaW50IHJlc29sdXRpb25fY29kZSA9IGNvZGU7CisJaW50
IHJlc29sdXRpb24gPSBoaWRpbnB1dF9jYWxjX2Fic19yZXMoZmllbGQsIHJlc29sdXRpb25fY29k
ZSk7CiAKIAlpZiAoZXF1aXZhbGVudF91c2FnZSA9PSBISURfREdfVFdJU1QpIHsKIAkJcmVzb2x1
dGlvbl9jb2RlID0gQUJTX1JaOwpAQCAtMTc1Niw4ICsxNzU3LDE1IEBAIHN0YXRpYyB2b2lkIHdh
Y29tX21hcF91c2FnZShzdHJ1Y3QgaW5wdXRfZGV2ICppbnB1dCwgc3RydWN0IGhpZF91c2FnZSAq
dXNhZ2UsCiAJc3dpdGNoICh0eXBlKSB7CiAJY2FzZSBFVl9BQlM6CiAJCWlucHV0X3NldF9hYnNf
cGFyYW1zKGlucHV0LCBjb2RlLCBmbWluLCBmbWF4LCBmdXp6LCAwKTsKLQkJaW5wdXRfYWJzX3Nl
dF9yZXMoaW5wdXQsIGNvZGUsCi0JCQkJICBoaWRpbnB1dF9jYWxjX2Fic19yZXMoZmllbGQsIHJl
c29sdXRpb25fY29kZSkpOworCisJCS8qIG9sZGVyIHRhYmxldCBtYXkgbWlzcyBwaHlzaWNhbCB1
c2FnZSAqLworCQlpZiAoKGNvZGUgPT0gQUJTX1ggfHwgY29kZSA9PSBBQlNfWSkgJiYgIXJlc29s
dXRpb24pIHsKKwkJCXJlc29sdXRpb24gPSBXQUNPTV9JTlRVT1NfUkVTOworCQkJaGlkX3dhcm4o
aW5wdXQsCisJCQkJICJXYWNvbSB1c2FnZSAoJWQpIG1pc3NpbmcgcmVzb2x1dGlvbiBcbiIsCisJ
CQkJIGNvZGUpOworCQl9CisJCWlucHV0X2Fic19zZXRfcmVzKGlucHV0LCBjb2RlLCByZXNvbHV0
aW9uKTsKIAkJYnJlYWs7CiAJY2FzZSBFVl9LRVk6CiAJCWlucHV0X3NldF9jYXBhYmlsaXR5KGlu
cHV0LCBFVl9LRVksIGNvZGUpOwotLSAKMi40MC4xCgo=
--000000000000e1e9dd05fb5fcb3c--
