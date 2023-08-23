Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 871B178645B
	for <lists+stable@lfdr.de>; Thu, 24 Aug 2023 02:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235723AbjHXA6Q (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 23 Aug 2023 20:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238933AbjHXA6J (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 23 Aug 2023 20:58:09 -0400
Received: from symantec4.comsats.net.pk (symantec4.comsats.net.pk [203.124.41.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7BB4E4E
        for <stable@vger.kernel.org>; Wed, 23 Aug 2023 17:58:02 -0700 (PDT)
X-AuditID: cb7c291e-06dff70000002aeb-bc-64e69624e28a
Received: from iesco.comsatshosting.com (iesco.comsatshosting.com [210.56.28.11])
        (using TLS with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by symantec4.comsats.net.pk (Symantec Messaging Gateway) with SMTP id 03.E4.10987.42696E46; Thu, 24 Aug 2023 04:28:36 +0500 (PKT)
DomainKey-Signature: a=rsa-sha1; c=nofws; q=dns;
        d=iesco.com.pk; s=default;
        h=received:content-type:mime-version:content-transfer-encoding
          :content-description:subject:to:from:date:reply-to;
        b=WZWEst2LR+i9K73/sfgdA1356tF2BcolfZluT7a3c3ZMUj5zJyfNoXE/iqMx5uNC/
          f4yRLWDkKQbGt8ZeqZ7zZA2qo+eToZdp/gHP2OpZuL2EAv794r7Yno/8I2qnX/a19
          +ZEur+iTj1Z1KyMLbGQ0tfUTtFxtfinZYWvLUJ53g=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=iesco.com.pk; s=default;
        h=reply-to:date:from:to:subject:content-description
          :content-transfer-encoding:mime-version:content-type;
        bh=GMzYzcyTxDsE6wX/XHG6MHqAdAiHrhqbmmLQ/TZ1QnQ=;
        b=aSDsxr/w8L7PGd542Gc0v78Ub1nhJ/szxjtkXerkXfzH0AyUo6vykK+Yw9s0l30/s
          o7D1hrXKyyqevAA+ERODJiODOFOc1fKguu6oCRyJ+4jK60wPhAORQnMeTsPfkt8Dd
          EkefWkJjIU7i6BVB1xcsEiiHEY+jsY+6Ck1V5xW5k=
Received: from [94.156.6.90] (UnknownHost [94.156.6.90]) by iesco.comsatshosting.com with SMTP;
   Thu, 24 Aug 2023 04:08:26 +0500
Message-ID: <03.E4.10987.42696E46@symantec4.comsats.net.pk>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: Re; Interest,
To:     stable@vger.kernel.org
From:   "Chen Yun" <conference@iesco.com.pk>
Date:   Wed, 23 Aug 2023 16:08:41 -0700
Reply-To: chnyne@gmail.com
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDLMWRmVeSWpSXmKPExsVyyUKGW1dl2rMUg4sPZSwWbHzE6MDo8XmT
        XABjFJdNSmpOZllqkb5dAlfGknUXWAp2M1e09S9iaWB8zNTFyMkhIWAiMW3aOdYuRi4OIYE9
        TBL/FrYzgTgsAquZJVZ/2csC4Txklrg87yELRFkzo8SMH0vB+nkFrCWOHtjFDGIzC+hJ3Jg6
        hQ0iLihxcuYTFoi4tsSyha+BajiAbDWJr10lIGFhATGJT9OWsYOERQSkJO5ftQYJswloSfyf
        vxdsOouAqsS3VQ1gU4SASjZeWc82gZF/FpJls5Asm4Vk2SyEZQsYWVYxShRX5iYCQy3ZRC85
        P7c4saRYLy+1RK8gexMjMAxP12jK7WBceinxEKMAB6MSD2/Bz6cpQqyJZUBdhxglOJiVRHi/
        +DxLEeJNSaysSi3Kjy8qzUktPsQozcGiJM5rK/QsWUggPbEkNTs1tSC1CCbLxMEp1cB4/cmD
        AIZD0lb6jidfe6UVi4pwnbvIfv5wrhJ/Z3mG9uLg2VcX79hxPfX1b7c2H6bGMnNv0yNPbG9t
        P5Zz4Ehjnv6jlLiUE2+OpW05+F/r5u3ak4XhRhq/j+1/Z8Cd1Bz6Y1Fszal1E1bXsiwt7Fmr
        5pr8Nm+p6ErLK+3n3JaFHg5xYkvcHa+hxFKckWioxVxUnAgAyf3RUT8CAAA=
X-Spam-Status: Yes, score=6.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_REPLYTO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SBL,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: *  0.0 RCVD_IN_DNSWL_BLOCKED RBL: ADMINISTRATOR NOTICE: The query to
        *      DNSWL was blocked.  See
        *      http://wiki.apache.org/spamassassin/DnsBlocklists#dnsbl-block
        *      for more information.
        *      [203.124.41.30 listed in list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.1 RCVD_IN_SBL RBL: Received via a relay in Spamhaus SBL
        *      [94.156.6.90 listed in zen.spamhaus.org]
        *  3.3 RCVD_IN_SBL_CSS RBL: Received via a relay in Spamhaus SBL-CSS
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  2.1 FREEMAIL_FORGED_REPLYTO Freemail in Reply-To, but not From
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Re; Interest,

I am interested in discussing the Investment proposal as I explained
in my previous mail. May you let me know your interest and the
possibility of a cooperation aimed for mutual interest.

Looking forward to your mail for further discussion.

Regards

------
Chen Yun - Chairman of CREC
China Railway Engineering Corporation - CRECG
China Railway Plaza, No.69 Fuxing Road, Haidian District, Beijing, P.R.
China

