Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDB317A83C3
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 15:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234550AbjITNqq (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 09:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234565AbjITNqp (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 09:46:45 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 153FCAC
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 06:46:39 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-40472f9db24so69749375e9.2
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 06:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695217597; x=1695822397; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cAM1wadeSyIjp7q3Vm93wQl3fXT/7CxJyrjA05VxHHI=;
        b=yshaFgi4Yi+V4B71O2mDc2bdPGKT8F2vizWNZqy16GnMpW7LMX5F8QXEWEiFADikoz
         OHDthICzZTVa8a5M4k1irrYTxH814l7RYyZGba2xd+UPfnF5YdHsnfcQ0y0zr7dw/TO4
         lRyPKfBmMnDRUxxYkaTRpZ21oL0dITXCjZ9DbMUX+EBqptHGcN3bcziHrMuP+vPqN0D2
         jNV0Hbxus9lynL9RqUgNm6vdN1aqu9d8wc9Bp2o9JK7Obl0th7WttA6D8DaP+RzDDEHJ
         v14XrxUnpHmgcTVc/xt0GmqP2Pi+h7Z/OAVrKNOyX70Tvznj3Sr+QWcKkLPPX2psDc0q
         YyLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695217597; x=1695822397;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cAM1wadeSyIjp7q3Vm93wQl3fXT/7CxJyrjA05VxHHI=;
        b=D/h0CzJ2dp6I1x3f9+kXoe0UO/c9r3yaJhzAI/JHLEZxwr/ITI68cYHwkkG9YclvVR
         LX6F8lAfhYg/j6qtzfHmDbkuaF2XaB3liZdaj0IreflrLr5/b/rExaNjHFxMtzWFfidT
         1nlmMldKfyAQ5benz3acuZ0Imn8EYne/QtrWiC1nzFbtu14R0mXJbdlISMOATbxsQCuU
         H5F5W4F9d5YBL9FBhF3hkKwmsqw2pvheFdVkZJrKd88pnewm8VkWuAQ6xbx5Q8glSPwV
         YLEUnWCdRrxPsYJ4TQ3O03MjXwQ4bUF5ZxDl910U6QDZscHa61axF4nmkfx3Jw6dUm8W
         gcpA==
X-Gm-Message-State: AOJu0YxW6tSnWHXwAmAX83nUW5zgGqvgDYBIzF6pMqT/op1qbAlkLgvl
        8PK2urhtLdd0mx+vppIbngikJQ==
X-Google-Smtp-Source: AGHT+IFbm0KhCiry33Vx93F5rLpq+lFcEYHKEkaTNlVhxvoLeU6XTDCsvfVSPISxoCiGd9wzuVCSWg==
X-Received: by 2002:a05:600c:144:b0:405:1ba2:4fc9 with SMTP id w4-20020a05600c014400b004051ba24fc9mr2524735wmm.15.1695217597366;
        Wed, 20 Sep 2023 06:46:37 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id u23-20020a05600c211700b004042dbb8925sm2010111wml.38.2023.09.20.06.46.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 06:46:36 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
To:     dri-devel@lists.freedesktop.org,
        Jani Nikula <jani.nikula@intel.com>
Cc:     Sam Ravnborg <sam@ravnborg.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
In-Reply-To: <20230914131015.2472029-1-jani.nikula@intel.com>
References: <20230914131015.2472029-1-jani.nikula@intel.com>
Subject: Re: [PATCH] drm/meson: fix memory leak on ->hpd_notify callback
Message-Id: <169521759637.2169873.6598076316992605754.b4-ty@linaro.org>
Date:   Wed, 20 Sep 2023 15:46:36 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi,

On Thu, 14 Sep 2023 16:10:15 +0300, Jani Nikula wrote:
> The EDID returned by drm_bridge_get_edid() needs to be freed.
> 
> 

Thanks, Applied to https://anongit.freedesktop.org/git/drm/drm-misc.git (drm-misc-fixes)

[1/1] drm/meson: fix memory leak on ->hpd_notify callback
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=099f0af9d98231bb74956ce92508e87cbcb896be

-- 
Neil

