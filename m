Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B02F478B8FB
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 22:03:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233602AbjH1UC6 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 16:02:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233670AbjH1UCj (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 16:02:39 -0400
X-Greylist: delayed 938 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 28 Aug 2023 13:02:13 PDT
Received: from symantec.comsats.net.pk (symantec.comsats.net.pk [210.56.11.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63C651B5
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 13:02:13 -0700 (PDT)
X-AuditID: d2380b23-3c1ff70000007104-e4-64ecf938eee8
Received: from iesco.comsatshosting.com (iesco.comsatshosting.com [210.56.28.11])
        (using TLS with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by symantec.comsats.net.pk (Symantec Messaging Gateway) with SMTP id 22.71.28932.839FCE46; Tue, 29 Aug 2023 00:44:56 +0500 (PKT)
DomainKey-Signature: a=rsa-sha1; c=nofws; q=dns;
        d=iesco.com.pk; s=default;
        h=received:content-type:mime-version:content-transfer-encoding
          :content-description:subject:to:from:date:reply-to;
        b=SvyhdqhdORDrE2A0XmacGl+BIqFmbol4IzlGXf8PayHnDu850mD7OYXqusaH1vomj
          4pDqkpkYhMiW0Ujm+HtHf8m1UiCjM61FLR06ZJY7aihnuhBPUIQQb7lRKxww6vzdS
          s4TMclja2LwMTeyrQ8YKHDubtWGrLHvdvJ2UrwKFs=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=iesco.com.pk; s=default;
        h=reply-to:date:from:to:subject:content-description
          :content-transfer-encoding:mime-version:content-type;
        bh=olmk80cLmZoXHNEULi94oyNYNSuJDPnVFjLFsR7WPgY=;
        b=U90oGQ/kKUH66Lh63DZwCFqbW8DsPWPIUb0OX4cLFioS5OwEIbReTd0NVskUk0XbF
          hlK1m1owzyAVVaBAGHS+pbOKyYyTttZJD6M05m2ziZrl0ICadDqaA1aD7+LCPo6Qu
          TV6VuIpw1iQ+jSKYKCJjsKxum3mMhVyLSRRTy+q/M=
Received: from [94.156.6.90] (UnknownHost [94.156.6.90]) by iesco.comsatshosting.com with SMTP;
   Tue, 29 Aug 2023 00:23:35 +0500
Message-ID: <22.71.28932.839FCE46@symantec.comsats.net.pk>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: Thanks for your response!
To:     stable@vger.kernel.org
From:   "Hou Qijun" <conference@iesco.com.pk>
Date:   Mon, 28 Aug 2023 12:23:55 -0700
Reply-To: qijunhou02@gmail.com
X-Brightmail-Tracker: H4sIAAAAAAAAA02TX0xbVRzHc3pLuSvc7XI74GfH9lDiNCzgRmZShzp9MC5isj3MGDWRXegt
        bSht7S0MNC51ewDr2NhWsOtcLdYtqESlbOgY1K5apgtGKYO44Fhcuk0KDmKtK1smnlNa2peT
        k8/vz/d7zu8cmuLCtJLWG62CxcgbVDK5NKwuyStXL81rtib6K9We/pvoObQr5tu0B70uf1oj
        GPTNguWJZ/fJdeP2SK75ItXiOtmba0MRiR2toYHdDsPegNSO5DTHXpRAxHcolwSk7BcUePu1
        JCBl/6BgvLMNrWQdQrCcuI9IFsPugI8jQ1Kyp9gK+K3LIVvhBfDTyUiKb4GzPXOUHdF4vxni
        divBClYFD0MPZQSvZ5VwY7KKYBnOHvAsSlc8PAp3ht0SksKxm+DyYHMnWufK0nJlabmytFwZ
        LQ+Sfo6KxdZGHt9ZXUWdqVHkrWKFUbBWmBt8KHmBeaXfIm9nTRCxNFLlM+22eQ2XwzfjoiCq
        piWqQuazGEZra02aVh0v6mosTQZBVK1nztzDmFnFtU2GBpWSKf8XU8UqNQr7RYNgxRMLIqAp
        XBZ+PorLNHzr24LFtNIsiDbQUlUxU7L5dh3H1vNWoUEQzIIlHd1L0ypguknnAotQL7Ro9QZr
        OozrAtVzGo7NjiTNbGReK8BaRdmBbD8Sek0Q7aLzsandt8hZRDPfKOrrU30VzHAc0/w0TfZ8
        hJkiNrg0zPS7gky0+8h3IxTdfncMr/FBe4DipEaTUVAWMwpSxZIqXZNx1buyiBkNYYvrsgJE
        RlnC+AkvzOIZpfTDj6IEwjNTMIULxCf+FxnzHBMi5vNSMOkdmD+TV5himYaVX+M+bJ8EZkZf
        hR89rhz4ITgtg0RgmYaBgw/yoe+rv4vgrscJ0Nc3CzB5YWwbXL11fTtEepaq4KNL378Iy7bw
        SxBvv/0y+B44dsORsdAr0HtwVgvRuX/MMBPoaAZnwvEuOBcH8R861r3wPoKu06OHEdwY+7UD
        wdUF51EEf13pOo4gtuz/EMG9qVG83uxxnkLwydLIaQThyRk3XocGPkVRPDgJHpzjG/KaRCtv
        zR5c3kiUDC5FU4PLIZBLw8zplTak3sBNlJ0o/d1Xdf3+/FNB/5exnB0Nb037++kDcz9fmC6t
        jNvKdEe1s6168fh750v3/dJdPjH+zlrHuY1aW/VQfU3omvvAB3dKXnCGrp33qo+dmZrZ6u09
        p3/88KU2aHssFrSdaHlDsCz+98ypnU86Lu/dKX9zer97y0RuB2U569fUiiqpqOO3lVEWkf8f
        8Fc/d+UEAAA=
X-Spam-Status: Yes, score=6.4 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_SBL,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: *  0.1 RCVD_IN_SBL RBL: Received via a relay in Spamhaus SBL
        *      [94.156.6.90 listed in zen.spamhaus.org]
        *  3.3 RCVD_IN_SBL_CSS RBL: Received via a relay in Spamhaus SBL-CSS
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [qijunhou02[at]gmail.com]
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  2.1 FREEMAIL_FORGED_REPLYTO Freemail in Reply-To, but not From
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Thanks for your response,


Kindly reconfirm your interest to further discuss the investment Thanks for=
 your response,


partnership within your country as I explained earlier so we can have a fur=
ther discussion to facilitate the process for mutual interest.

Looking forward to your response.

Hou Qijun
Vice President- CNPC
China National Petroleum Corporation
No. 9 Dongzhimen North Street Dongcheng District Beijing.

