Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E03176F1F0
	for <lists+stable@lfdr.de>; Thu,  3 Aug 2023 20:36:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232978AbjHCSgR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 3 Aug 2023 14:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231254AbjHCSgQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 3 Aug 2023 14:36:16 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A11C2D42
        for <stable@vger.kernel.org>; Thu,  3 Aug 2023 11:36:15 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4fe4f5290daso2207160e87.1
        for <stable@vger.kernel.org>; Thu, 03 Aug 2023 11:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1691087773; x=1691692573;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bjK7RUYhJ3o/ZdfV6zCLpQPvuk/yGcfZkOCyD/T1w4M=;
        b=BrZIJzPS8/nphMMUSPTsqlcNKZIP1VxUgEbJEpWV/1dO1z8be/bQCYvXxqCITxkmpc
         80lSPno+8k7LzCXEKfVo2bJrMsb5DXjvjjfktPML0/PhhKRuDAWk/eKBiOsEtN6Dssnw
         PXyeq1jHoLMPHJNgNStzHa0CbGMgAm7cch/S0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691087773; x=1691692573;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bjK7RUYhJ3o/ZdfV6zCLpQPvuk/yGcfZkOCyD/T1w4M=;
        b=d3/hk0I3V56NqKUySPLS016PlEun08fiB+EByGQqXC0P/duKzDEyzFUEPFajzD6KQj
         A0ep7jWVrlDNXUeSErpIqqYJnppOeE0rvir4uUJ67SxKDMzP5GzRrbbKoVtJxKByLEX7
         b+Su0Ia30dBcpx0TFpe3G6nvOIxfq652ZCnXHbd3nu7ChXWCOY9YE+AekfVaGt0MiQGX
         Pjxorx3EAMVArfyrVxOTQsIo4i2BUW1Cl9jIKESZvq4Yzu3eH7YICHmkK+Q4kqZdN1Jy
         rdY7NkaZJrTV06fCBwNisxgWxMhYrlckWwo3d/8izN/b+1qu0QBCNQQH3R9cnHGfGhXW
         92OQ==
X-Gm-Message-State: ABy/qLZzyIZ+Kr+s4vaXxZ0yj/+czjgk9Ut6K3SAaN4BnIAvqS3v4NF+
        UG1hkYjaxFL1nUCw82JCLVvRTxvg7uFCIdgEX+JIms2+
X-Google-Smtp-Source: APBJJlGOCF7YokNrKXDXyyibchbe5nSYaNyG5fQcBHXyL2CpM/03BXwX/Y84nRYlD0nu01MmK7wv3A==
X-Received: by 2002:a2e:86c8:0:b0:2b9:e304:5f81 with SMTP id n8-20020a2e86c8000000b002b9e3045f81mr8318175ljj.23.1691087773313;
        Thu, 03 Aug 2023 11:36:13 -0700 (PDT)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id k10-20020a1709067aca00b0099364d9f0e9sm160026ejo.102.2023.08.03.11.36.11
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Aug 2023 11:36:11 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5231410ab27so573796a12.0
        for <stable@vger.kernel.org>; Thu, 03 Aug 2023 11:36:11 -0700 (PDT)
X-Received: by 2002:a05:6402:60e:b0:522:27c4:3865 with SMTP id
 n14-20020a056402060e00b0052227c43865mr7594168edv.41.1691087771299; Thu, 03
 Aug 2023 11:36:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230724-vfs-fdget_pos-v1-1-a4abfd7103f3@kernel.org>
 <CAHk-=whfJhag+iEscftpVq=dHTeL7rQopCvH+Pcs8vJHCGNvXQ@mail.gmail.com>
 <20230724-pyjama-papier-9e4cdf5359cb@brauner> <CAHk-=wj2XZqex6kzz7SbdVHwP9fFoOvHSzHj--0KuxyrVO+3-w@mail.gmail.com>
 <20230803095311.ijpvhx3fyrbkasul@f> <CAHk-=whQ51+rKrnUYeuw3EgJMv2RJrwd7UO9qCgOkUdJzcirWw@mail.gmail.com>
 <20230803-libellen-klebrig-0a9e19dfa7dd@brauner>
In-Reply-To: <20230803-libellen-klebrig-0a9e19dfa7dd@brauner>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 3 Aug 2023 11:35:53 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi97khTatMKCvJD4tBkf6rMKTP=fLQDnok7MGEEewSz9g@mail.gmail.com>
Message-ID: <CAHk-=wi97khTatMKCvJD4tBkf6rMKTP=fLQDnok7MGEEewSz9g@mail.gmail.com>
Subject: Re: [PATCH] file: always lock position
To:     Christian Brauner <brauner@kernel.org>
Cc:     Mateusz Guzik <mjguzik@gmail.com>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Seth Forshee <sforshee@kernel.org>,
        linux-fsdevel@vger.kernel.org, stable@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000e529550602090d09"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

--000000000000e529550602090d09
Content-Type: text/plain; charset="UTF-8"

On Thu, 3 Aug 2023 at 11:03, Christian Brauner <brauner@kernel.org> wrote:
>
> Only thing that's missing is exclusion with seek on directories
> as that's the heinous part.

Bah. I forgot about lseek entirely, because for some completely stupid
reason I just thought "Oh, that will always get the lock".

So I guess we'd just have to do that "unconditional fdget_dir()" thing
in the header file after all, and make llseek() and ksys_lseek() use
it.

Bah. And then we'd still have to worry about any filesystem that
allows 'read()' and 'write()' on the directory - which can also update
f_pos.

And yes, those exist. See at least 'adfs_dir_ops', and
'ceph_dir_fops'. They may be broken, but people actually did do things
like that historically, maybe there's a reason adfs and ceph allow it.

End result: we can forget about fdget_dir(). We'd need to split
FMODE_ATOMIC_POS into two instead.

I don't think we have any free flags, but I didn't check. The ugly
thing to do is to just special-case S_ISDIR. Not lovely, but whatever.

So something like this instead? It's a smaller diff anyway, and it
gets the crazy afds/ceph cases right too.

And by "gets them right" I obviously mean "I didn't actually *TEST*
any of this, so who knows..."

             Linus

--000000000000e529550602090d09
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_lkvhzg8u0>
X-Attachment-Id: f_lkvhzg8u0

IGZzL2ZpbGUuYyB8IDE4ICsrKysrKysrKysrKysrKysrLQogMSBmaWxlIGNoYW5nZWQsIDE3IGlu
c2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9mcy9maWxlLmMgYi9mcy9m
aWxlLmMKaW5kZXggMzVjNjJiNTRjOWQ2Li5kYmNhMjZlZjdhMDEgMTAwNjQ0Ci0tLSBhL2ZzL2Zp
bGUuYworKysgYi9mcy9maWxlLmMKQEAgLTEwMzYsMTIgKzEwMzYsMjggQEAgdW5zaWduZWQgbG9u
ZyBfX2ZkZ2V0X3Jhdyh1bnNpZ25lZCBpbnQgZmQpCiAJcmV0dXJuIF9fZmdldF9saWdodChmZCwg
MCk7CiB9CiAKKy8qCisgKiBUcnkgdG8gYXZvaWQgZl9wb3MgbG9ja2luZy4gV2Ugb25seSBuZWVk
IGl0IGlmIHRoZQorICogZmlsZSBpcyBtYXJrZWQgZm9yIEZNT0RFX0FUT01JQ19QT1MsIGFuZCBp
dCBjYW4gYmUKKyAqIGFjY2Vzc2VkIG11bHRpcGxlIHdheXMuCisgKgorICogQWx3YXlzIGRvIGl0
IGZvciBkaXJlY3RvcmllcywgYmVjYXVzZSBwaWRmZF9nZXRmZCgpCisgKiBjYW4gbWFrZSBhIGZp
bGUgYWNjZXNzaWJsZSBldmVuIGlmIGl0IG90aGVyd2lzZSB3b3VsZAorICogbm90IGJlLCBhbmQg
Zm9yIGRpcmVjdG9yaWVzIHRoaXMgaXMgYSBjb3JyZWN0bmVzcworICogaXNzdWUsIG5vdCBhICJQ
T1NJWCByZXF1aXJlbWVudCIuCisgKi8KK3N0YXRpYyBpbmxpbmUgYm9vbCBmaWxlX25lZWRzX2Zf
cG9zX2xvY2soc3RydWN0IGZpbGUgKmZpbGUpCit7CisJcmV0dXJuIChmaWxlLT5mX21vZGUgJiBG
TU9ERV9BVE9NSUNfUE9TKSAmJgorCQkoZmlsZV9jb3VudChmaWxlKSA+IDEgfHwgU19JU0RJUihm
aWxlX2lub2RlKGZpbGUpLT5pX21vZGUpKTsKK30KKwogdW5zaWduZWQgbG9uZyBfX2ZkZ2V0X3Bv
cyh1bnNpZ25lZCBpbnQgZmQpCiB7CiAJdW5zaWduZWQgbG9uZyB2ID0gX19mZGdldChmZCk7CiAJ
c3RydWN0IGZpbGUgKmZpbGUgPSAoc3RydWN0IGZpbGUgKikodiAmIH4zKTsKIAotCWlmIChmaWxl
ICYmIChmaWxlLT5mX21vZGUgJiBGTU9ERV9BVE9NSUNfUE9TKSkgeworCWlmIChmaWxlICYmIGZp
bGVfbmVlZHNfZl9wb3NfbG9jayhmaWxlKSkgewogCQl2IHw9IEZEUFVUX1BPU19VTkxPQ0s7CiAJ
CW11dGV4X2xvY2soJmZpbGUtPmZfcG9zX2xvY2spOwogCX0K
--000000000000e529550602090d09--
